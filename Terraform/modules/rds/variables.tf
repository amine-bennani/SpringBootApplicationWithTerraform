variable "region" {
  description = "AWS region"
  type        = string
}

variable "db_name" {
  description = "Name of the RDS database"
  type        = string
}

variable "azs" {
  description = "List of availability zones for RDS instances"
  type        = string
}

variable "db_security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "db_subnet_group_name" {
  description = "DB subnet group name"
  type        = string
}
