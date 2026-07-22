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