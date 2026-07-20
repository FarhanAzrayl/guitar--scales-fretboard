# This is just to enable a lock, meaning kinda like a token/session in which if one person runs apply, if another person tries to run apply they will see that state is locked
# This is taken from the Terraform documentation > DynamoDB > aws_dynamodb_table

resource "aws_dynamodb_table" "terraform_locks" {

  name         = var.lock_table_name
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

# type = "S" means its String btw
  attribute {
    name = "LockID"
    type = "S"
  }

# Macam biasa, tagging / metadata for filtering, automation etc for later when we upgrade and employ CI/CD
  tags = {
    Name        = "Terraform Locks"
    Project     = "Guitar Fretboard"
    Environment = "Bootstrap"
    ManagedBy   = "Terraform"
  }

}