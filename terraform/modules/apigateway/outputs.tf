# Outputs api_id, execution_arn, invoke_url
# Only exporting the value that another module (Lambda, sebab kita pakai ni untuk access Lambda) needs.

output "execution_arn" {
  description = "API Gateway execution ARN."
  value       = aws_apigatewayv2_api.http.execution_arn
}


# Outputs the API endpoint (Check in Terraform Plan first before Applying)
output "api_endpoint" {
  description = "HTTP API endpoint."
  value       = aws_apigatewayv2_api.http.api_endpoint
}