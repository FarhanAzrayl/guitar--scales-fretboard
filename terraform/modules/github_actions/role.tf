# This is the IAM Role - Kita define dekat sini - Who is this? Nama dia apa? Dari department mana etc

resource "aws_iam_role" "github_actions" {
  # We take from var.role_name variable yang kita create on this module
  name = var.role_name 

  # We take from trust_policy within this module - Imagine dia pakai the role/tag/jacket that allows him to do things, which in this case is to run the GitHub repo actions
  assume_role_policy = data.aws_iam_policy_document.github_actions_trust.json

  tags = var.tags
}

# Later bila kita nak add Admin to login and dia boleh add scales etc, we add it here