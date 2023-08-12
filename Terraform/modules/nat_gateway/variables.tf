variable "public_subnet_ids" {
  description = "List of public subnet IDs where NAT Gateways will be created"
  type        = list(string)
}

variable "vpc_id" {
  value = string
}