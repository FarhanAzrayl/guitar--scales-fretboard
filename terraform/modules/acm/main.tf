# We jsut add this provider here instead of another .tf file to reduce clutter
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_acm_certificate" "this" {

  domain_name = var.domain_name

  subject_alternative_names = var.subject_alternative_names

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}