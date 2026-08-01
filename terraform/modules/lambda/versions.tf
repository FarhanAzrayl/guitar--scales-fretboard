# Need to remember that archive_file is a resource from HashiCorp Archive and not AWS. That's why we create this

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }

    archive = {
      source = "hashicorp/archive"
    }
  }
}