variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
  default     = "192.168.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "eip_private_ip" {
  description = "Private IP for NAT Gateway EIP"
  type        = string
  default     = "192.168.0.5"
}

variable "public_subnet_1_cidr" {
  description = "Public Subnet 1 CIDR"
  type        = string
  default     = "192.168.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "Public Subnet 2 CIDR"
  type        = string
  default     = "192.168.2.0/24"
}

variable "public_subnet_3_cidr" {
  description = "Public Subnet 3 CIDR"
  type        = string
  default     = "192.168.3.0/24"
}

variable "private_subnet_1_cidr" {
  description = "Private Subnet 1 CIDR"
  type        = string
  default     = "192.168.4.0/24"
}

variable "private_subnet_2_cidr" {
  description = "Private Subnet 2 CIDR"
  type        = string
  default     = "192.168.5.0/24"
}

variable "private_subnet_3_cidr" {
  description = "Private Subnet 3 CIDR"
  type        = string
  default     = "192.168.6.0/24"
}

variable "environment" {
  description = "Environment name (dev/stg/prod)"
  type        = string
}

variable "vm-size" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}