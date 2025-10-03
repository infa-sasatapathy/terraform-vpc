output "vpc_id" {
  value = module.vpc.vpc_id
}
output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  value = [
    module.vpc.public_subnet_1_id,
    module.vpc.public_subnet_2_id,
    module.vpc.public_subnet_3_id
  ]
}

output "private_subnet_ids" {
  value = [
    module.vpc.private_subnet_1_id,
    module.vpc.private_subnet_2_id,
    module.vpc.private_subnet_3_id
  ]
}
