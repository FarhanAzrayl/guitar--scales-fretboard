# Who can assume/use this Role - Authentication
# This is to create the IAM trust policy for GitHub Actions.
# It's basically to use the deployment role using OIDC we already created/have with AWS.

# Ni ada dalam data.tf. Policy ni untuk allow only the approved GitHub repositories on the main branch
data "aws_iam_policy_document" "github_actions_trust" {

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type = "Federated"

      identifiers = [
        data.aws_iam_openid_connect_provider.github.arn
      ]
    }

    condition {
      # Just remember that GitHub token should always say "sts.amazonaws.com"
      # Kita dah setup at the OIDC configurations so we make sure that within this policy it is refencing exactly that
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"

      values = [
        for repository in var.allowed_repositories :
        "repo:${repository}:ref:refs/heads/main"
      ]
    }
  }
}