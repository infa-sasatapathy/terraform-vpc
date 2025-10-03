variable "region" {
  description = "AWS Region"
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
}

variable "public_subnet_1_cidr" {}
variable "public_subnet_2_cidr" {}
variable "public_subnet_3_cidr" {}

variable "private_subnet_1_cidr" {}
variable "private_subnet_2_cidr" {}
variable "private_subnet_3_cidr" {}

variable "environment" {
  description = "Environment name (dev/stg/prod)"
  type        = string
}
