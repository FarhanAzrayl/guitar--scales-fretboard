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