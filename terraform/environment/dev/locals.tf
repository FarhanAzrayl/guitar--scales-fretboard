locals {

  # When this environment sends information to the module, instead of sending the information such as project name from the tags in .tfvars one by one
  # we can containerize them within this tag "housing" and send only common_tags for tagging

  bucket_name = "${var.project_name}-${var.environment}-website"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}