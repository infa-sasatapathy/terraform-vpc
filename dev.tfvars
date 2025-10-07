# dev.tfvars
vpc_name              = "dev-vpc"
vpc_cidr              = "10.0.0.0/16"
public_subnets        = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets       = ["10.0.3.0/24", "10.0.4.0/24"]
eip_private_ip        = "10.0.0.5"
vm-size               = "t2.micro"