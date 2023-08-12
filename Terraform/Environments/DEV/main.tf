module "vpc" {
  source = "../modules/vpc"
  vpc_cidr = "10.0.0.0/16"
}

module "subnets" {
  source = "../modules/subnets"
  vpc_id                 = module.vpc.vpc_id
  availability_zones     = ["us-east-1a"]
  public_subnet_cidrs    = ["10.0.1.0/24"]
  private_subnet_cidrs   = ["10.0.11.0/24"]

}

module "nat_gateway" {
  source = "../modules/nat_gateway"
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.subnets.public_subnet_ids
}

module "bastion" {
  source = "../modules/bastion"
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.subnets.public_subnet_ids
  bastion_ami = var.bastion_ami
  bastion_instance_type = var.bastion_instance_type
  key_name = var.key_name
}


module "security_groups" {
  source = "../modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "load_balancer" {
  source = "../modules/load_balancer"
  public_subnet_ids = module.subnets.public_subnet_ids
}

resource "aws_instance" "dev_instance" {
  count         = 1
  instance_type = "t2.micro"
  subnet_id     = module.subnets.public_subnet_ids[0]
  key_name      = var.key_name

  tags = {
    Name = "DevInstance"
  }
}

