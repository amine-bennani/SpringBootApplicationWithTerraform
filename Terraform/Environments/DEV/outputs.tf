output "dev_vpc_id" {
  value = module.vpc.vpc_id
}

output "dev_public_subnet_ids" {
  value = module.subnets.public_subnet_ids
}

output "dev_private_subnet_ids" {
  value = module.subnets.private_subnet_ids
}

output "dev_nat_gateway_ids" {
  value = module.nat_gateway.nat_gateway_ids
}

output "dev_bastion_instance_ids" {
  value = module.bastion.bastion_instance_ids
}

output "dev_security_group_ids" {
  value = module.security_groups.security_groups_ids
}

output "dev_load_balancer_dns_name" {
  value = module.load_balancer.load_balancer_dns_name
}
