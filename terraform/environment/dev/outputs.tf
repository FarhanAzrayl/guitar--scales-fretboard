# Just use terraform output command instead of the aws CLI command to see whether this is being sent out or is sending out incorrect outputs later on

output "cloudfront_domain_name" {
  description = "CloudFront domain name."

  value = module.cloudfront.distribution_domain_name
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID."

  value = module.cloudfront.distribution_id
}