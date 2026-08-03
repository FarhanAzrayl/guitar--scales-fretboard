output "table_name" {
  description = "Scales table name."

  value = aws_dynamodb_table.scales.name
}

output "table_arn" {
  description = "Scales table ARN."

  value = aws_dynamodb_table.scales.arn
}