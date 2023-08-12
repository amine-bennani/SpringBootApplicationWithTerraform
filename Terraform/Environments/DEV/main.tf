module "vpc" {
  source = "../../modules/vpc"
}

#####################################################################
#                      SUBNETS                                      #
#####################################################################

module "subnets" {
  source                = "../../modules/subnets"
  vpc_id                = module.vpc.vpc_id
  availability_zone     = var.availability_zone
  public_subnet_cidr    = ["10.0.1.0/24"]
  private_subnet_cidr   = ["10.0.11.0/24"]
  env_name              = "DEV"
}

#####################################################################
#                         BASTION                                   #
#####################################################################

module "bastion" {
  source                 = "../../modules/bastion"
  vpc_id                 = module.vpc.vpc_id
  public_subnet_ids      = module.subnets.public_subnet_ids
  bastion_ami            = var.bastion_ami
  bastion_instance_type  = var.bastion_instance_type
  key_name               = var.key_name
  zone                   = var.availability_zone
  security_group_ids     = module.security_groups.bastion_security_group_id
}

#####################################################################
#                       SECURITY GROUPS                             #
#####################################################################

module "security_groups" {
  source                 = "../../modules/security_groups"
  vpc_id                 = module.vpc.vpc_id
  trusted_ip_ranges      = ["0.0.0.0/0"]
}

#####################################################################
#                      EC2 INSTANCE                                 #
#####################################################################

data "aws_ami" "latest_amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name      = "name"
    values    = ["amzn2-ami-hvm-2.0.*-x86_64-ebs"]
  }
}

resource "aws_instance" "bastion_dev_instance" {
  count                  = 1
  ami                    = data.aws_ami.latest_amazon_linux_2.id
  instance_type          = "t3.micro"
  subnet_id              = module.subnets.private_subnet_ids
  key_name               = var.key_name
  monitoring             = true
  vpc_security_group_ids = [module.security_groups.bastion_security_group_id]

  tags = {
    Name = "DevInstance"
  }
}

#####################################################################
#                         RDS INSTANCE                              #
#####################################################################

module "rds" {
  source                = "../../modules/rds"
  azs                   = "var.availability_zone"
  db_name               = "dev_db"
  db_security_group_ids = []
  db_subnet_group_name  = module.subnets.private_subnet_ids
  region = ""
}

#####################################################################
#                       ROUTE TABLES                                #
#####################################################################





