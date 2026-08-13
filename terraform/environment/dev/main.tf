
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

# Connecting the Domain that was purchased and already setup in ACN via Console

module "acm" {
  source = "../../modules/acm"

  providers = {
    aws = aws.us_east_1
  }

  domain_name = "guitar-fretboard.com"

  subject_alternative_names = [
    "*.guitar-fretboard.com"
  ]
  tags = local.common_tags
}

module "cloudfront" {
  source = "../../modules/cloudfront"

  bucket_regional_domain_name = module.s3.bucket_regional_domain_name
  project_name                = var.project_name
  environment                 = var.environment
  tags                        = local.common_tags

  # Declaring the domain name here
  domain_name         = "guitar-fretboard.com"
  acm_certificate_arn = module.acm.certificate_arn
}

# This is the extra module we had to create because of the circular dependancy issue we faced btw. Flaw in earlier design

module "s3_bucket_policy" {
  source                      = "../../modules/s3_bucket_policy"
  bucket_id                   = module.s3.bucket_id
  bucket_arn                  = module.s3.bucket_arn
  cloudfront_distribution_arn = module.cloudfront.distribution_arn
}

# GitHub Actions for CI/CD Pipeline of the project
module "github_actions" {
  source = "../../modules/github_actions"

  role_name = "${var.project_name}-${var.environment}-github-actions"

  # Add Repo's here
  # Full link: https://github.com/FarhanAzrayl/guitar--scales-fretboard
  allowed_repositories = [
    "FarhanAzrayl/guitar--scales-fretboard"
  ]

  tags = local.common_tags
}


module "lambda" {

  source = "../../modules/lambda"

  project_name = var.project_name
  environment  = var.environment

  # Kita tambah 2 ni sebab taknak separate the table permission for these two tables in DynamoDB for Lambda > No need to add a new module lagi.
  # We will refer these from the scales and tunings module that we created
  scales_table_arn  = module.scales.table_arn
  tunings_table_arn = module.tunings.table_arn

  # Same as above, tapi ni untuk parse the table names, atas is to parse the ARN's
  scales_table_name  = module.scales.table_name
  tunings_table_name = module.tunings.table_name


  tags = local.common_tags
}

module "apigateway" {
  source            = "../../modules/apigateway"
  project_name      = var.project_name
  environment       = var.environment
  lambda_invoke_arn = module.lambda.lambda_invoke_arn
  tags              = local.common_tags

  # This is for CORS Cloudfront access > This is to read the CloudFront as https://d1hlg16pug3eiu.cloudfront.net for example
  allowed_origins = [
    "https://${module.cloudfront.distribution_domain_name}"
  ]
}

# Adding this lambda_permissions module to resolve circular dependancy issue > API Gateway needed information from Lambda (ARN)

module "lambda_permission" {

  source = "../../modules/lambda/lambda_permission"

  lambda_function_name     = module.lambda.lambda_function_name
  apigateway_execution_arn = module.apigateway.execution_arn
}

module "scales" {

  source = "../../modules/dynamodb/scales"

  project_name = var.project_name
  environment  = var.environment
  tags         = local.common_tags
}


module "tunings" {

  source = "../../modules/dynamodb/tunings"

  project_name = var.project_name
  environment  = var.environment
  tags         = local.common_tags
}

# Disabling this since we are separating the tables on different modules (Remember that we want to implement serverless so lets not use RDS, malas nak manage SQL queries)

/*
module "dynamodb" {
  source = "../../modules/dynamodb"
}
*/