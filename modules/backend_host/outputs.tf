output "instance_id" {
  description = "Backend EC2 instance ID"
  value       = aws_instance.this.id
}

output "instance_public_ip" {
  description = "Backend EC2 EIP"
  value       = aws_eip.this.public_ip
}

output "instance_private_ip" {
  description = "Backend EC2 private IP"
  value       = aws_instance.this.private_ip
}

output "security_group_id" {
  description = "Backend EC2 security group ID"
  value       = aws_security_group.ec2.id
}

output "iam_role_name" {
  description = "Backend EC2 IAM role name"
  value       = aws_iam_role.ec2.name
}
