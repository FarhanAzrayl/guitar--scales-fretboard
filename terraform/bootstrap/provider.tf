# Just to declare which provider are we using on this Terraform. For example, if we are building with an Azure platform it will be "provider "azurerm" {}" etc etc
# And also, no need to hard core the region since we want to simulate a production where we might want to deploy to other regions. So var.aws_region tu we will take the value from .tfvars in which all the values kita store
# Lets say the prod is in Singapore, but we want to test first in dev for Tokyo for example. Bootstrap is also our literaly bootstrap so its like the default (as of now)

provider "aws" {
  region = var.aws_region
}