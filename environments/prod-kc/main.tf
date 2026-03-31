locals {
  name_prefix = "${var.project_name}-${var.environment}"
  api_fqdn    = "${var.api_subdomain}.${var.domain_name}"
  app_port    = 80

  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
    },
    var.tags
  )
}

module "network_inputs" {
  source = "../../modules/network_inputs"

  vpc_id                = var.vpc_id
  alb_public_subnet_ids = var.alb_public_subnet_ids
  ec2_public_subnet_id  = var.ec2_public_subnet_id
  route53_zone_id       = var.route53_zone_id
}

module "storage" {
  source = "../../modules/storage"

  bucket_name = var.s3_bucket_name
  tags        = local.common_tags
}

module "edge_tls" {
  source = "../../modules/edge_tls"

  name_prefix             = local.name_prefix
  vpc_id                  = module.network_inputs.vpc_id
  alb_subnet_ids          = module.network_inputs.alb_public_subnet_ids
  certificate_domain_name = local.api_fqdn
  route53_zone_id         = module.network_inputs.route53_zone_id
  target_port             = local.app_port
  health_check_path       = var.health_check_path
  tags                    = local.common_tags
}

module "backend_host" {
  source = "../../modules/backend_host"

  name_prefix           = local.name_prefix
  vpc_id                = module.network_inputs.vpc_id
  subnet_id             = module.network_inputs.ec2_public_subnet_id
  instance_type         = var.instance_type
  ami_id                = var.ami_id
  key_name              = var.ec2_key_name
  allowed_ssh_cidrs     = var.allowed_ssh_cidrs
  alb_security_group_id = module.edge_tls.alb_security_group_id
  app_port              = local.app_port
  app_s3_bucket_arns    = [module.storage.bucket_arn]
  user_data_extra       = var.user_data_extra
  tags                  = local.common_tags
}

module "config_ssm" {
  source = "../../modules/config_ssm"

  name_prefix      = local.name_prefix
  parameter_prefix = var.ssm_parameter_prefix
  parameters       = var.ssm_parameters
  ec2_role_name    = module.backend_host.iam_role_name
  kms_key_arns     = var.ssm_kms_key_arns
  tags             = local.common_tags
}

resource "aws_lb_target_group_attachment" "backend" {
  target_group_arn = module.edge_tls.target_group_arn
  target_id        = module.backend_host.instance_id
  port             = local.app_port
}

resource "aws_route53_record" "api_alias" {
  zone_id = module.network_inputs.route53_zone_id
  name    = local.api_fqdn
  type    = "A"

  alias {
    name                   = module.edge_tls.alb_dns_name
    zone_id                = module.edge_tls.alb_zone_id
    evaluate_target_health = true
  }
}
