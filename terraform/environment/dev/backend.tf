terraform {

  backend "s3" {
    # If there are issues with the name of the bucket, check in the .tfvars file
    bucket         = "tfstate-for-guitar-project"
    # This is not a directory, but only the name of this variable within environment/dev that was created
    key            = "environment/dev/terraform.tfstate"
    region         = "ap-southeast-1"
    # If there are issues with the name of the bucket, check in the .tfvars file
    dynamodb_table = "terraform-locks"
  }
}