# Tags SHOULD BE defined from the environments. Make sure all environments have a locals.tf with common tags

resource "aws_s3_bucket" "website" {
  bucket = var.bucket_name
  tags   = var.tags
}

# Versioning - we set it up so previous versions of uploaded files are retained and just in case there are bugs on the latest deployment version, so then we could rollback to the previous working version

resource "aws_s3_bucket_versioning" "website" {

  # Notice that this bucket is using aws_s3_bucket.website.id instead of var.bucket_name again, same as the resource above.
  # We can, but this method is basically us using the internal resource that we have within this module, which in this case is from the resource above this one 

  bucket = aws_s3_bucket.website.id
  versioning_configuration {
    status = "Enabled"
  }
}


# Encrypt all objects stored in the bucket using SSE-S3 (AES256).
# This protects data at rest without requiring customer-managed KMS keys.
# This is to prevent lets say someone got the physical hard drive that contains this bucket. This ensures that it is still encrypted despite that situation

resource "aws_s3_bucket_server_side_encryption_configuration" "website" {
  bucket = aws_s3_bucket.website.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


# Prevent accidental public exposure of the bucket, no matter what access has been given to the user.
# CloudFront will be the only service allowed to access buckets created using this module that has the below rules.

resource "aws_s3_bucket_public_access_block" "website" {

  bucket = aws_s3_bucket.website.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}


# To make sure that bucket owner owns all uploaded objects, despite whoever uploads it, lets say a colleague who is also using the same resource.

resource "aws_s3_bucket_ownership_controls" "website" {

  bucket = aws_s3_bucket.website.id
  
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}