data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnet" "alb" {
  for_each = toset(var.alb_public_subnet_ids)
  id       = each.value
}

data "aws_subnet" "ec2" {
  id = var.ec2_public_subnet_id
}

data "aws_route53_zone" "selected" {
  zone_id = var.route53_zone_id
}
