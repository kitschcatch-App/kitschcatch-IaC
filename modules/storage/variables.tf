variable "bucket_name" {
  description = "S3 bucket name for application assets"
  type        = string
}

variable "force_destroy" {
  description = "Force destroy bucket even when not empty"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
