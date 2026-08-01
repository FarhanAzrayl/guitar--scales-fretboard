variable "project_name" {
  description = "Project name used for resource naming."

  type = string
}

variable "environment" {
  description = "Deployment environment."

  type = string
}

variable "tags" {
  description = "Tags applied to all Lambda resources."

  type = map(string)
}