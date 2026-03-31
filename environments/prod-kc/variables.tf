variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "kitschcatch"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod-kc"
}

variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
}

variable "alb_public_subnet_ids" {
  description = "Public subnet IDs for ALB"
  type        = list(string)

  validation {
    condition     = length(var.alb_public_subnet_ids) >= 2
    error_message = "At least 2 subnets are required for ALB."
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

variable "api_subdomain" {
  description = "API subdomain"
  type        = string
  default     = "api"
}

variable "domain_name" {
  description = "Root domain name (e.g. kitschcatch.com)"
  type        = string
}

variable "allowed_ssh_cidrs" {
  description = "Allowed CIDRs for SSH"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t4g.small"
}

variable "ami_id" {
  description = "Optional AMI ID"
  type        = string
  default     = null
}

variable "ec2_key_name" {
  description = "EC2 key pair name for SSH deployment"
  type        = string
}

variable "health_check_path" {
  description = "ALB target health check path"
  type        = string
  default     = "/actuator/health"
}

variable "ssm_parameter_prefix" {
  description = "SSM parameter prefix for backend"
  type        = string
  default     = "/kitschcatch/prod-kc/backend"
}

variable "ssm_kms_key_arns" {
  description = "KMS key ARNs for decrypting SecureString parameters"
  type        = list(string)
  default     = []
}

variable "s3_bucket_name" {
  description = "S3 bucket name for backend assets"
  type        = string
}

variable "ssm_parameters" {
  description = "SSM parameter map"
  type = map(object({
    value       = string
    type        = optional(string, "SecureString")
    description = optional(string, "")
  }))
}

variable "user_data_extra" {
  description = "Additional cloud-init/user-data script"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
