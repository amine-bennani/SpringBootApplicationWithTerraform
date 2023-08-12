output "bastion_security_group_id" {
  description = "ID of the security group for Bastion hosts"
  value       = aws_security_group.bastion_sg.id
}

output "web_security_group_id" {
  description = "ID of the security group for web servers"
  value       = aws_security_group.web_sg.id
}

output "security_groups_ids" {
  description = "IDs of the created security groups"
  value       = aws_security_group.bastion_sg[*].id
}

output "rds_security_group_id" {
  description = "ID of the security group for RDS instance"
  value       = aws_security_group.rds_sg.id
}