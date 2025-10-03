variable "region" {
  default     = "ap-south-1"
  description = "AWS Region"
}

variable "environment" {
  description = "Environment name (dev/stg/prod)"
  type        = string
}

variable "vpc_cidr" {
  default     = "192.168.0.0/16"
  description = "VPC CIDR Block"
}

variable "public_subnet_1_cidr" { default = "192.168.1.0/24" }
variable "public_subnet_2_cidr" { default = "192.168.2.0/24" }
variable "public_subnet_3_cidr" { default = "192.168.3.0/24" }
variable "private_subnet_1_cidr" { default = "192.168.4.0/24" }
variable "private_subnet_2_cidr" { default = "192.168.5.0/24" }
variable "private_subnet_3_cidr" { default = "192.168.6.0/24" }
