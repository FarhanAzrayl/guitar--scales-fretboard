# Think of it like you are declaring a variable in a programming. Bro, nama pun variable. Lets just solidify on the concept

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "state_bucket_name" {
  description = "Terraform State Bucket"
  type        = string
}

variable "lock_table_name" {
  description = "Terraform Lock Table"
  type        = string
}