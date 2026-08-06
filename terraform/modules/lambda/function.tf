# # Letak nama lambda je karang lupa. And also Python version and timeout hardcore je sini, overcomplicating nanti susah debug

resource "aws_lambda_function" "lambda" {

  # This creates guitar-fretboard-dev (No need to be guitar-fretboard-dev-lambda since this service is already Lambda. Baik pendekkan function names)
  function_name = "${var.project_name}-${var.environment}"

  role    = aws_iam_role.lambda.arn
  runtime = "python3.13"

  # Terraform reads as lambda_handler() - Dalam handler kita ada "def lambda_handler(event, context)"
  handler = "handler.lambda_handler"

  # AWS creates the ZIPfile, not the folder
  filename = data.archive_file.lambda.output_path

  source_code_hash = data.archive_file.lambda.output_base64sha256
  timeout          = 10
  architectures = [
    "x86_64"
  ]

  # Remember that IAM's uses ARN for authorization, not the table names. Just try to internalize that ARNs > IAM permissions.
  environment {
    variables = {
      SCALES_TABLE  = var.scales_table_name
      TUNINGS_TABLE = var.tunings_table_name
    }
  }
}