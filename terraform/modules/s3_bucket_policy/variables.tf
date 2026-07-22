# All of these are basically parsed from the Cloudfront module

variable "bucket_id" {
  description = "ID of the S3 bucket."

  type = string
}

variable "bucket_arn" {
  description = "ARN of the S3 bucket."

  type = string
}

variable "cloudfront_distribution_arn" {
  description = "ARN of the CloudFront distribution allowed to access this bucket."

  type = string
}