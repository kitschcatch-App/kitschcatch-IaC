output "api_fqdn" {
  description = "Public API FQDN"
  value       = aws_route53_record.api_alias.fqdn
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = module.edge_tls.alb_dns_name
}

output "ec2_public_ip" {
  description = "Backend EC2 public IP"
  value       = module.backend_host.instance_public_ip
}

output "ec2_instance_id" {
  description = "Backend EC2 instance ID"
  value       = module.backend_host.instance_id
}

output "s3_bucket_name" {
  description = "Application S3 bucket name"
  value       = module.storage.bucket_name
}

output "ssm_parameter_prefix" {
  description = "SSM parameter prefix"
  value       = module.config_ssm.parameter_prefix
}
