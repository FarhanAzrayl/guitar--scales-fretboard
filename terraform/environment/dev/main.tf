
# Just remember that this is the state/declaration of what services will be used. If any services need to be added/removed, check/edit/declare/undeclare here

module "s3" {
  source = "../../modules/s3"
}

module "cloudfront" {
  source = "../../modules/cloudfront"

  bucket_domain_name = module.s3.bucket_domain_name
}

module "lambda" {
  source = "../../modules/lambda"
}

module "apigateway" {
  source = "../../modules/apigateway"

  lambda_arn = module.lambda.lambda_arn
}

module "dynamodb" {
  source = "../../modules/dynamodb"
}