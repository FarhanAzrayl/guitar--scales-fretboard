# Every value here supplied by whoever (the environment dev, test, or prod) is calling this module such as the bucket name, tags etc 

variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "project_name" {
  description = "Project name used for naming and tagging."
  type        = string
}

variable "tags" {
  description = "Common tags applied to resources."
  type        = map(string)
}


variable "website_source_path" {
  description = "Path to the frontend website files."

  type = string
}

/* 
No longer needeed because we had to create a bucket policy module btw - issue with dependancy > fixed!!
# AWS Resource Name that will be parsed from Cloudfront to identify who is it (Which Cloudfron identity/ARN) and will include all the information this bucket needs to provide access to it
# In this case we just want to access GETObject for our files
variable "cloudfront_distribution_arn" {
  description = "ARN of the CloudFront distribution allowed to access this bucket."
  type        = string
}
*/