output "distribution_id" {
  description = "CloudFront Distribution ID."
  value       = aws_cloudfront_distribution.website.id
}

output "distribution_domain_name" {
  description = "CloudFront domain name."
  value       = aws_cloudfront_distribution.website.domain_name
}

output "distribution_arn" {
  description = "The CloudFront distribution ARN."
  value = aws_cloudfront_distribution.website.arn
}