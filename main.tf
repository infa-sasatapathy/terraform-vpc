provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"

  vpc_name       = "production"
  vpc_cidr       = var.vpc_cidr
  eip_private_ip = "192.168.0.5"

  public_subnets = {
    pub1 = { cidr = var.public_subnet_1_cidr, az = "ap-south-1a" }
    pub2 = { cidr = var.public_subnet_2_cidr, az = "ap-south-1b" }
    pub3 = { cidr = var.public_subnet_3_cidr, az = "ap-south-1c" }
  }

  private_subnets = {
    priv1 = { cidr = var.private_subnet_1_cidr, az = "ap-south-1a" }
    priv2 = { cidr = var.private_subnet_2_cidr, az = "ap-south-1b" }
    priv3 = { cidr = var.private_subnet_3_cidr, az = "ap-south-1c" }
  }
}
