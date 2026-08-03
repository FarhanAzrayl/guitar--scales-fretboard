# Stores all guitar scales such as Major, Minor, Dorian, Pentatonic etc etc

resource "aws_dynamodb_table" "scales" {

  # Example if this will be: guitar-fretboard-dev-scales, guitar-fretboard-prod-scales
  name = "${var.project_name}-${var.environment}-scales"

  billing_mode = "PAY_PER_REQUEST"

  hash_key = "ScaleName"

  attribute {
    name = "ScaleName"
    type = "S"
  }

  tags = var.tags
}