# AWS region where the GitHub OIDC provider will be created.
variable "aws_region" {
  description = "AWS region where the OIDC provider will be created."

  type = string
}

# Common tags applied to resources created by this bootstrap configuration.
variable "tags" {
  description = "Common resource tags."

  type = map(string)
}