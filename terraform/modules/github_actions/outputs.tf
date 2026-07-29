output "role_name" {
  description = "GitHub Actions IAM Role name."

  value = aws_iam_role.github_actions.name
}

output "role_arn" {
  description = "GitHub Actions IAM Role ARN."

  value = aws_iam_role.github_actions.arn
}

output "policy_arn" {
  description = "Deployment policy ARN."

  value = aws_iam_policy.github_actions.arn
}