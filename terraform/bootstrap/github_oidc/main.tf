# The link is the identity provider AWS trusts for all GitHub Actions workflows.
# Repository restrictions are enforced later by the IAM role's trust policy,
# not by the OIDC provider itself.

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  tags = var.tags
}

# This is using Amazon STS btw