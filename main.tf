provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr       = var.vpc_cidr
  vpc_name       = var.vpc_name
  eip_private_ip = var.eip_private_ip

  public_subnets  = [var.public_subnet_1_cidr, var.public_subnet_2_cidr, var.public_subnet_3_cidr]
  private_subnets = [var.private_subnet_1_cidr, var.private_subnet_2_cidr, var.private_subnet_3_cidr]

  environment = var.environment
}

# Outputs from module
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}
