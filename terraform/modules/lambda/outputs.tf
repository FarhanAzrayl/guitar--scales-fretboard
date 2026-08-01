output "lambda_invoke_arn" {
  description = "Lambda Invoke ARN."

  value = aws_lambda_function.lambda.invoke_arn
}

output "lambda_function_name" {
  description = "Lambda function name."

  value = aws_lambda_function.lambda.function_name
}