variable "public_subnet_ids" {
  description = "List of public subnet IDs where the load balancer will be placed"
  type        = list(string)
}
