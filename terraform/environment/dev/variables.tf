variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}


/* We declare these 2 from the module. If this is present, when running terrafrm plan, it will ask to input a value because it is reading from the variable here instead of the module
# Added these 2 for Domains / ACM that was added
variable "domain_name" {
  description = "Custom domain name for the CloudFront distribution."
  type        = string
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate used by CloudFront."
  type        = string
}
*/