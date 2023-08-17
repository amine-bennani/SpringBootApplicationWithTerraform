module "vpc" {
  source   = "../../modules/vpc"
}

module "subnets" {
  source               = "../../modules/subnets"
  vpc_id               = module.vpc.vpc_id
  availability_zones   = var.availability_zone  # Different AZ from dev and UAT environments
  public_subnet_cidrs  = ["10.0.3.0/48"]  # Example CIDR, adjust as needed
  private_subnet_cidrs = ["10.0.13.0/24"]  # Example CIDR, adjust as needed
}

module "nat_gateway" {
  source = "../../modules/nat_gateway"
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.subnets.public_subnet_ids[2]
}

module "bastion" {
  source = "../../modules/bastion"
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.subnets.public_subnet_ids[2]
  bastion_ami = var.bastion_ami
  bastion_instance_type = var.bastion_instance_type
  key_name = var.key_name
  zone = var.availability_zone
}


module "security_groups" {
  source = "../../modules/security_groups"
  vpc_id = module.vpc.vpc_id
  trusted_ip_ranges = ["0.0.0.0/0"]
}

module "load_balancer" {
  source = "../../modules/load_balancer"
  public_subnet_ids = module.subnets.public_subnet_ids[2]
}

data "aws_ami" "latest_amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*-x86_64-ebs"]
  }
}

resource "aws_instance" "dev_instance" {
  count         = 1
  ami           = data.aws_ami.latest_amazon_linux_2.id
  instance_type = "t2.micro"
  subnet_id     = module.subnets.public_subnet_ids[0]
  key_name      = var.key_name

  vpc_security_group_ids = [module.security_groups.bastion_security_group_id]  # Add the relevant security group ID(s)

  tags = {
    Name = "DevInstance"
  }
}


