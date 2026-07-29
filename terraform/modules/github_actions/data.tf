# This is to Discover the OIDC provider - Read existing AWS resources from modules lain ke, from environment ke etc

# We reuse the existing GitHub OICD provider that kita initially created within our AWS account, not just on Bootstrap and we don't create a new one
data "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
}