# This is the Lambda IAM Role
resource "aws_iam_role" "lambda" {

  # Example of output would be: guitar-fretboard-dev-lambda, guitar-fretboard-test-lambda, guitar-fretboard-prod-lambda
  name = "${var.project_name}-${var.environment}-lambda"

  assume_role_policy = data.aws_iam_policy_document.lambda_trust.json

  tags = var.tags
}


# This is the AWS Managed Policy
resource "aws_iam_role_policy_attachment" "basic_execution" {

  role = aws_iam_role.lambda.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

##################################
# This is the DynamoDB Permissions sectopm.
# Lets not add another module so that everything related to Lambda will be located here, senang sikit nak cari nanti
##################################

data "aws_iam_policy_document" "dynamodb" {

  statement {
    sid    = "ReadScalesAndTunings"
    effect = "Allow"

    actions = [
      # Lets not use /* if possible. Kita nak train the concept of least privillege
      "dynamodb:GetItem",
      "dynamodb:Query", # Ni untuk advanced lookups in case kita perlu later (Refer to the Terraform Registry documentation)
      "dynamodb:Scan"   # Scan/search the table
    ]

    resources = [
      var.scales_table_arn,
      var.tunings_table_arn
    ]
  }
}

# Example name dia akan produce: guitar-fretboard-dev-lambda-dynamodb, guitar-fretboard-prod-lambda-dynamodb etc
resource "aws_iam_policy" "dynamodb" {
  name        = "${var.project_name}-${var.environment}-lambda-dynamodb"
  description = "Allows Lambda to read DynamoDB tables."
  policy      = data.aws_iam_policy_document.dynamodb.json
}

resource "aws_iam_role_policy_attachment" "dynamodb" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.dynamodb.arn
}