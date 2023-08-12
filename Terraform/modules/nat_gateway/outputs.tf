output "nat_gateway_ids" {
  description = "IDs of the created NAT Gateways"
  value       = aws_nat_gateway.nat_gateways[*].id
}

output "nat_gateway_eip_ids" {
  description = "IDs of the EIPs associated with the NAT Gateways"
  value       = aws_eip.nat_eips[*].id
}
