variable "name_prefix" {
  description = "Name prefix for resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for EC2"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ami_id" {
  description = "Optional AMI ID. If null, latest Amazon Linux 2023 AMI is used"
  type        = string
  default     = null
}

variable "key_name" {
  description = "EC2 key pair name for SSH access"
  type        = string
}

variable "allowed_ssh_cidrs" {
  description = "Allowed CIDRs for SSH access"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "ALB security group ID allowed to access app port"
  type        = string
}

variable "app_port" {
  description = "Backend listener port on EC2"
  type        = number
  default     = 80
}

variable "app_s3_bucket_arns" {
  description = "S3 bucket ARNs the backend can access"
  type        = list(string)
  default     = []
}

variable "user_data_extra" {
  description = "Optional additional user-data shell commands"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
