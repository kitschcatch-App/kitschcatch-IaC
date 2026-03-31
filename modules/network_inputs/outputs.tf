output "vpc_id" {
  description = "Resolved VPC ID"
  value       = data.aws_vpc.selected.id
}

output "alb_public_subnet_ids" {
  description = "Resolved ALB public subnet IDs"
  value       = var.alb_public_subnet_ids
}

output "ec2_public_subnet_id" {
  description = "Resolved EC2 public subnet ID"
  value       = data.aws_subnet.ec2.id
}

output "route53_zone_id" {
  description = "Resolved Route53 zone ID"
  value       = data.aws_route53_zone.selected.zone_id
}

output "route53_zone_name" {
  description = "Resolved Route53 zone name"
  value       = data.aws_route53_zone.selected.name
}
