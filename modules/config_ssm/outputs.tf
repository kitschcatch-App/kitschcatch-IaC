output "parameter_prefix" {
  description = "Resolved SSM parameter prefix"
  value       = local.normalized_prefix
}

output "parameter_names" {
  description = "Created SSM parameter names"
  value       = [for parameter in aws_ssm_parameter.this : parameter.name]
}

output "read_policy_arn" {
  description = "IAM policy ARN for SSM read"
  value       = aws_iam_policy.ssm_read.arn
}
