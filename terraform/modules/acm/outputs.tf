output "certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = aws_acm_certificate.this.arn
}

output "certificate_domain_name" {
  description = "Primary domain name of the certificate"
  value       = aws_acm_certificate.this.domain_name
}

output "domain_validation_options" {
  description = "DNS validation records required for the ACM certificate"
  value       = aws_acm_certificate.this.domain_validation_options
}