# Adding CORS to this API Gateway for Cloudfront access

cors_configuration {
  allow_origins = var.allowed_origins

  allow_methods = [
    # Just use all lah senang
    "*"
  ]

  allow_headers = [
    "Content-Type"
  ]

  allow_credentials = false
}