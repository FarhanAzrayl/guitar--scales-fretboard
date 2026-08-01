# Allows our API Gateway to invoke this Lambda function
# This is now obselete since we had to create a new module due to the the API Gateway calling a resource from Lambda back creating a circular dependancy

/*
resource "aws_lambda_permission" "apigateway" {
  statement_id = "AllowExecutionFromAPIGateway"

  # Kita only allow the API to invoke, nothing else
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name

  # This is saying/answering "who is allowed?" when API Gateway is trying to access Lambda
  principal = "apigateway.amazonaws.com"

  # Ni untuk specify that only THIS gateway can access this Lambda
  source_arn = var.apigateway_execution_arn
}
*/