
# 

resource "aws_s3_bucket" "terraform_state" {

  bucket = var.state_bucket_name

  # Just for tagging kinda like a metadata information so we can find this belongs to which project, which environment etc. This data could also be used for filtering and automation etc
  tags = {
    Name        = "Terraform State Bucket"
    Project     = "Guitar Fretboard"
    Environment = "Bootstrap"
    ManagedBy   = "Terraform"
  }

}

resource "aws_s3_bucket_versioning" "terraform_state" {

  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }

}