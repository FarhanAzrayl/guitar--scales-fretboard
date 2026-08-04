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

# Ni kita add for the variables of tables tunings and scales > To parse the ARN

variable "scales_table_arn" {
  description = "ARN of the Scales DynamoDB table."

  type = string
}

variable "tunings_table_arn" {
  description = "ARN of the Tunings DynamoDB table."

  type = string
}