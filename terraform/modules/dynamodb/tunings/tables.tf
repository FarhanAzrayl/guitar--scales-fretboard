# We stores available guitar tunings here; Standard, Drop D, DADGAD, Drop C, Open D etc

# We just copy from scales as it is similar
resource "aws_dynamodb_table" "tunings" {

  name = "${var.project_name}-${var.environment}-tunings"

  billing_mode = "PAY_PER_REQUEST"

  hash_key = "TuningName"

  attribute {
    name = "TuningName"
    type = "S"
  }

  tags = var.tags
}