data "aws_iam_policy_document" "lambda_trust" {

  statement {
    sid    = "LambdaAssumeRole"
    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"

      identifiers = [
        "lambda.amazonaws.com"
      ]
    }
  }
}


# Terraform creates the Zipfile that we want Lambda to read nanti
data "archive_file" "lambda" {

  type       = "zip"
  source_dir = "${path.module}/code"

  # this is the Zipfile name that Terraform creates
  output_path = "${path.module}/lambda.zip"
}
