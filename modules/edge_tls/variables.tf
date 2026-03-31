variable "name_prefix" {
  description = "Name prefix for resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "alb_subnet_ids" {
  description = "Public subnet IDs for ALB"
  type        = list(string)

  validation {
    condition     = length(var.alb_subnet_ids) >= 2
    error_message = "At least 2 subnets are required for ALB."
  }
}

variable "certificate_domain_name" {
  description = "FQDN for ACM certificate"
  type        = string
}

variable "route53_zone_id" {
  description = "Hosted zone ID for DNS validation"
  type        = string
}

variable "target_port" {
  description = "Target group port"
  type        = number
  default     = 80
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
  default     = "/actuator/health"
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
