variable "aws_region" {
  description = "AWS region for bootstrap resources"
  type        = string
  default     = "ap-northeast-2"
}

variable "state_bucket_name" {
  description = "Globally unique S3 bucket name for Terraform state"
  type        = string
}

variable "lock_table_name" {
  description = "DynamoDB table name for Terraform state locking"
  type        = string
  default     = "kitschcatch-terraform-locks"
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
