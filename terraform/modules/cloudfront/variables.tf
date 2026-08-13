# We pull this from the Outputs from the S3 module

variable "bucket_regional_domain_name" {
  description = "Regional domain name of the S3 bucket used as the CloudFront origin."
  type        = string
}

# These are from the tags parsed from the environment btw

variable "project_name" {
  description = "Project name used for naming resources."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "tags" {
  description = "Common tags applied to all CloudFront resources."
  type        = map(string)
}


# Adding these 2 to connect the domains / ACM

variable "domain_name" {
  description = "Custom domain name for the CloudFront distribution."
  type        = string
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate used by CloudFront."
  type        = string
}