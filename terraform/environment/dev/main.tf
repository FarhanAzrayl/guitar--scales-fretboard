
# Just remember that this is the main declaration of which modules will we use / point to. If a modules needs to be added or a redundant module needs to be removed, do it here

module "s3" {

  source = "../../modules/s3"

  # Bucket name is pulled from locals
  bucket_name         = local.bucket_name
  environment         = var.environment
  project_name        = var.project_name
  tags                = local.common_tags
  website_source_path = "../../../frontend"

  # This is the ARN for Cloudfront

  /*
  No longer needed sebab kita dah create the bucket policy module juuust below the cloudfront module there. See? See??
  cloudfront_distribution_arn = module.cloudfront.distribution_arn
  */
}

module "cloudfront" {
  source = "../../modules/cloudfront"

  bucket_regional_domain_name = module.s3.bucket_regional_domain_name
  project_name                = var.project_name
  environment                 = var.environment
  tags                        = local.common_tags
}

# This is the extra module we had to create because of the circular dependancy issue we faced btw. Flaw in earlier design

module "s3_bucket_policy" {
  source                      = "../../modules/s3_bucket_policy"
  bucket_id                   = module.s3.bucket_id
  bucket_arn                  = module.s3.bucket_arn
  cloudfront_distribution_arn = module.cloudfront.distribution_arn
}


# Disabling the other services first for testing as they are not built yet


/*
module "lambda" {
  source = "../../modules/lambda"
}
*/

/*
module "apigateway" {
  source = "../../modules/apigateway"

  lambda_arn = module.lambda.lambda_arn
}
*/

/*
module "dynamodb" {
  source = "../../modules/dynamodb"
}
*/