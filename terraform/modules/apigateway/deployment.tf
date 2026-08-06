# Creates Deployment, Stage - Basically saying "Yo, publish/send out this API"

# Connects the HTTP API to the Lambda function.
resource "aws_apigatewayv2_integration" "lambda" {
  api_id                 = aws_apigatewayv2_api.http.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.lambda_invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

# Routing of the API Gateway, basically macam the reception bagi direction where to go

# Ni untuk API endpoint for scales table
resource "aws_apigatewayv2_route" "scales" {

  api_id = aws_apigatewayv2_api.http.id

  # Matches every HTTP method and every path
  # This will be based on Lambda's: event["requestContext"]["http"]["method"] and event["rawPath"] in the Zipfile handler

  # Ni untuk get scales
  route_key = "GET /scales"

  # Okay so this tells the call that this route uses this integration which involves THIS Lambda. Route only knows the integration, they know nothing about our Lambda
  target = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}


# Ni untuk API endpoint for tunings table
resource "aws_apigatewayv2_route" "tunings" {

  api_id = aws_apigatewayv2_api.http.id

  # Matches every HTTP method and every path
  # This will be based on Lambda's: event["requestContext"]["http"]["method"] and event["rawPath"] in the Zipfile handler

  # Ni untuk get scales
  route_key = "GET /tunings"

  # Okay so this tells the call that this route uses this integration which involves THIS Lambda. Route only knows the integration, they know nothing about our Lambda
  target = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}


# This is the part where this module publishes the API so it becomes accessible
resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.http.id
  name        = "$default"
  auto_deploy = true
  tags        = var.tags
}