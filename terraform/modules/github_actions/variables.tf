variable "role_name" {
  description = "Name of the IAM role assumed by GitHub Actions."

  type = string
}

# Variable for the list of repo yang kita nak allow for the OIDC/token to access

variable "allowed_repositories" {
  description = "GitHub repositories allowed to assume this role."

  type = list(string)
}

variable "tags" {
  description = "Common resource tags."

  type = map(string)
}