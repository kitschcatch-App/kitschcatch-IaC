variable "name_prefix" {
  description = "Name prefix for resources"
  type        = string
}

variable "parameter_prefix" {
  description = "SSM parameter prefix (e.g. /kitschcatch/dev-kc/backend)"
  type        = string
}

variable "parameters" {
  description = "Key-value parameters to create under the prefix"
  type = map(object({
    value       = string
    type        = optional(string, "SecureString")
    description = optional(string, "")
  }))
}

variable "ec2_role_name" {
  description = "EC2 IAM role name that will read parameters"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
