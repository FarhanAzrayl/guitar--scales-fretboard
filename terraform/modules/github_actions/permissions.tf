# What this Role can do and list of functionalities yang dia can access - Authorization

data "aws_iam_policy_document" "github_actions_permissions" {

  # This is for GitHub's S3 access
  statement {
    sid    = "S3Access"
    effect = "Allow"

    actions = [
      "s3:*"
    ]

    resources = ["*"]
  }

  # This is for GitHub's Cloudfront Access
  statement {
    sid    = "CloudFrontAccess"
    effect = "Allow"

    actions = [
      "cloudfront:*"
    ]

    resources = ["*"]
  }

  # This is for GitHub's Lambda Access
  statement {
    sid    = "LambdaAccess"
    effect = "Allow"

    actions = [
      "lambda:*"
    ]

    resources = ["*"]
  }

  # This is for GitHub's API Gateway Access
  statement {
    sid    = "ApiGatewayAccess"
    effect = "Allow"

    actions = [
      "apigateway:*"
    ]

    resources = ["*"]
  }

  # This is for GitHub's DynamoDB Access
  statement {
    sid    = "DynamoDBAccess"
    effect = "Allow"

    actions = [
      "dynamodb:*"
    ]

    resources = ["*"]
  }

  # This is for GitHub's CloudWatch Access
  statement {
    sid    = "CloudWatchLogsAccess"
    effect = "Allow"

    actions = [
      "logs:*"
    ]

    resources = ["*"]
  }


  # This is for GitHub's IAM Role Access (Jangan bagi :*, we give mana we need only)
  statement {
    sid    = "IAMAccess"
    effect = "Allow"

    actions = [

      # If we keep having to add Roles here one by one for each access error we face, lets just use :* xD

      # Roles
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:GetRole",
      "iam:UpdateRole",
      "iam:PassRole",
      "iam:TagRole",
      "iam:UntagRole",

      # Policies
      "iam:CreatePolicy",
      "iam:DeletePolicy",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:ListPolicyVersions",
      "iam:CreatePolicyVersion",
      "iam:DeletePolicyVersion",

      # Role Attachments
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:ListAttachedRolePolicies",
      "iam:ListAttachedRolePolicies",
      "iam:ListRolePolicies",

      # OIDC Providers
      "iam:GetOpenIDConnectProvider",
      "iam:ListOpenIDConnectProviders"
    ]

    resources = ["*"]
  }

}

resource "aws_iam_policy" "github_actions" {
  name        = "${var.role_name}-deployment-policy"
  description = "Permissions for GitHub Actions deployments."

  policy = data.aws_iam_policy_document.github_actions_permissions.json
}


resource "aws_iam_role_policy_attachment" "github_actions" {
  role       = aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.github_actions.arn


}
