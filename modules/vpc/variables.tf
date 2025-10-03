variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "eip_private_ip" {
  description = "Private IP for NAT Gateway EIP"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "environment" {
  description = "Environment name (dev/stg/prod)"
  type        = string
}
