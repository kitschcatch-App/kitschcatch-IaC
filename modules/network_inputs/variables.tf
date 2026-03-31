variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
}

variable "alb_public_subnet_ids" {
  description = "Public subnet IDs for ALB (minimum 2)"
  type        = list(string)

  validation {
    condition     = length(var.alb_public_subnet_ids) >= 2
    error_message = "At least 2 public subnets are required for ALB."
  }
}

variable "ec2_public_subnet_id" {
  description = "Public subnet ID for backend EC2"
  type        = string
}

variable "route53_zone_id" {
  description = "Existing Route53 hosted zone ID"
  type        = string
}
