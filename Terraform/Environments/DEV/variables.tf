variable "bastion_ami" {
  description = "AMI ID for bastion instance"
  type        = string
}

variable "bastion_instance_type" {
  description = "Instance type for bastion instance"
  type        = string
}

variable "key_name" {
  description = "EC2 Key Pair name for bastion instance"
  type        = string
}
