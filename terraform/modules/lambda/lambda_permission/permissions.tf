# Allows this API Gateway to invoke the Lambda function.

resource "aws_lambda_permission" "apigateway" {

  statement_id = "AllowExecutionFromAPIGateway"

  # Kita only allow the API to invoke, nothing else
  action = "lambda:InvokeFunction"

  function_name = var.lambda_function_name

  # This is saying/answering "who is allowed?" when API Gateway is trying to access Lambda
  principal = "apigateway.amazonaws.com"

  # Ni untuk specify that only THIS gateway can access this Lambda
  source_arn = "${var.apigateway_execution_arn}/*"
}