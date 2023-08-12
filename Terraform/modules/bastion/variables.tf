variable "public_subnet_ids" {
  description = "List of public subnet IDs where Bastion hosts will be created"
  type        = list(string)
}

variable "bastion_ami" {
  description = "AMI ID for the Bastion host"
  type        = string
}

variable "bastion_instance_type" {
  description = "Instance type for the Bastion host"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair to use"
  type        = string
}

variable "zone" {
  description = "The primary zone where the bastion host will live"
  type        = string
}