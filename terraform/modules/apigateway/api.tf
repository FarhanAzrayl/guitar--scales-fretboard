# Creates the API Gateway HTTP API that the frontend/browser calls.

# Ni untuk createe the HTTP API that clients (frontend/browser) will call
# Check documentation on Terraform registry, this is where we declare that we we are using aws_apigatewayv2 > V2, lets not use the older one
resource "aws_apigatewayv2_api" "http" {

  # Example of output: guitar-fretboard-dev-api, guitar-fretboard-prod-api
  name = "${var.project_name}-${var.environment}-api"

  protocol_type = "HTTP"

  # Adding CORS to this API Gateway for Cloudfront access

  cors_configuration {
    allow_origins = var.allowed_origins

    allow_methods = [
      # Just use all lah senang
      "*"

      /*
    Examples for later if nak improve and applykan the concept of least privillege
    "GET",
    "OPTIONS"
    */

    ]

    allow_headers = [
      "Content-Type"
    ]

    allow_credentials = false
  }

  tags = var.tags
}


