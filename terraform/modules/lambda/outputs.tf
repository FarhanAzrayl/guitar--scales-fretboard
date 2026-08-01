output "lambda_invoke_arn" {
  description = "Lambda Invoke ARN."

  value = aws_lambda_function.lambda.invoke_arn
}