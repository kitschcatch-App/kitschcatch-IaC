data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  normalized_prefix = startswith(var.parameter_prefix, "/") ? trimsuffix(var.parameter_prefix, "/") : "/${trimsuffix(var.parameter_prefix, "/")}"
  parameter_arn     = "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter${local.normalized_prefix}/*"
}

resource "aws_ssm_parameter" "this" {
  for_each = var.parameters

  name        = "${local.normalized_prefix}/${each.key}"
  type        = each.value.type
  value       = each.value.value
  description = each.value.description != "" ? each.value.description : "Managed by Terraform"
  tier        = "Standard"

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-${each.key}"
  })
}

resource "aws_iam_policy" "ssm_read" {
  name = "${var.name_prefix}-ssm-read-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath"
        ]
        Resource = [
          local.parameter_arn
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt"
        ]
        Resource = "*"
      }
    ]
  })

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-ssm-read-policy"
  })
}

resource "aws_iam_role_policy_attachment" "ec2_ssm_read" {
  role       = var.ec2_role_name
  policy_arn = aws_iam_policy.ssm_read.arn
}
