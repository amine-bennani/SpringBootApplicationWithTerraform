output "public_subnet_ids" {
  description = "IDs of the created public subnets"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_ids" {
  description = "IDs of the created private subnets"
  value       = aws_subnet.private_subnet.id
}
