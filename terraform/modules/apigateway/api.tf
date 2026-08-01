# Creates the API Gateway HTTP API that the frontend/browser calls.

# Ni untuk createe the HTTP API that clients (frontend/browser) will call
# Check documentation on Terraform registry, this is where we declare that we we are using aws_apigatewayv2 > V2, lets not use the older one
resource "aws_apigatewayv2_api" "http" {

  # Example of output: guitar-fretboard-dev-api, guitar-fretboard-prod-api
  name = "${var.project_name}-${var.environment}-api"

  protocol_type = "HTTP"

  tags = var.tags
}