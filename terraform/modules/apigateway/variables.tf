# Ingat, we are passing the Invoke ARN only since that is what API Gateway needs to integrate with our created Lambda.

variable "project_name" {
  description = "Project name used for resource naming."

  type = string
}

variable "environment" {
  description = "Deployment environment."

  type = string
}

variable "lambda_invoke_arn" {
  description = "Lambda Invoke ARN."

  type = string
}

variable "tags" {
  description = "Tags applied to API Gateway."

  type = map(string)
}