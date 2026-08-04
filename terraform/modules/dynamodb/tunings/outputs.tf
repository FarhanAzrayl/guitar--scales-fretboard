output "table_name" {
  description = "Tunings table name."

  value = aws_dynamodb_table.tunings.name
}

output "table_arn" {
  description = "Tunings table ARN."

  value = aws_dynamodb_table.tunings.arn
}