# Just use terraform output command instead of the aws CLI command to see whether this is being sent out or is sending out incorrect outputs later on

# CloudFront's outputs

output "cloudfront_domain_name" {
  description = "CloudFront domain name."

  value = module.cloudfront.distribution_domain_name
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID."

  value = module.cloudfront.distribution_id
}

# GitHub's outputs

output "github_actions_role_name" {
  description = "IAM Role name used by GitHub Actions."

  value = module.github_actions.role_name
}

output "github_actions_role_arn" {
  description = "IAM Role ARN used by GitHub Actions."

  value = module.github_actions.role_arn
}

output "github_actions_policy_arn" {
  description = "Deployment policy ARN."

  value = module.github_actions.policy_arn
}

# Outputting the API endpoint - always check if correct before Applying
output "api_endpoint" {
  value = module.apigateway.api_endpoint
}