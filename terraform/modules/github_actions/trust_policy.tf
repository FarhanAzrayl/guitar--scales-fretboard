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

    # We are hard coding the repo here since the last time we used the old GitHub's immutable object claim. Now GitHub has updated (Can refer to Repo > Settings > OIDC)
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"

      values = [
        "repo:FarhanAzrayl@294132580/guitar--scales-fretboard@1306462761:ref:refs/heads/main"
      ]
    }
  }
}