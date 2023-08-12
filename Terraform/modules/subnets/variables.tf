variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}


variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  type        = string
}

variable "availability_zone"  {
  description = "The availability zone where the X environment will be deployed"
  type = string
}

variable "env_name"  {
  description = "The name of the subnet based on its environment"
  type = string
}