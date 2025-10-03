variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "eip_private_ip" {
  description = "Private IP for EIP (used with NAT)"
  type        = string
}

variable "public_subnets" {
  description = "List of Public Subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of Private Subnet CIDRs"
  type        = list(string)
}

variable "environment" {
  description = "Environment name (dev/stg/prod)"
  type        = string
}
