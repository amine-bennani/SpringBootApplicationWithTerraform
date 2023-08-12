provider "aws" {
  region = var.region
}


resource "aws_db_instance" "mysql_instance" {
  allocated_storage    = 20
  db_name           = var.db_name
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "root"
  password             = "Assiya-102964"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot = true
  allow_major_version_upgrade = true
  vpc_security_group_ids      = var.db_security_group_ids
  db_subnet_group_name        = var.db_subnet_group_name
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = var.db_name
  }
}

