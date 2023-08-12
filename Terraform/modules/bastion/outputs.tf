output "bastion_instance_ids" {
  description = "IDs of the created Bastion instances"
  value       = aws_instance.bastion_instances[*].id
}

output "bastion_security_group_ids" {
  description = "IDs of the security groups for Bastion instances"
  value       = aws_security_group.bastion_sg[*].id
}
