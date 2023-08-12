output "uat_vpc_id" {
  value = module.vpc.vpc_id
}

output "uat_public_subnet_ids" {
  value = module.subnets.public_subnet_ids
}

output "uat_private_subnet_ids" {
  value = module.subnets.private_subnet_ids
}

output "uat_nat_gateway_ids" {
  value = module.nat_gateway.nat_gateway_ids
}

output "uat_bastion_instance_ids" {
  value = module.bastion.bastion_instance_ids
}

output "uat_security_group_ids" {
  value = module.security_groups.security_groups_ids
}

output "uat_load_balancer_dns_name" {
  value = module.load_balancer.load_balancer_dns_name
}
