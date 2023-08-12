resource "aws_instance" "bastion_instance" {
  count         = length(var.public_subnet_ids)
  ami           = var.bastion_ami
  instance_type = var.bastion_instance_type
  subnet_id     = element(var.public_subnet_ids, count.index)
  key_name      = var.key_name
  machine_type  = "n1-standard-1"
  zone          = var.zone

  tags = {
    Name = format("Bastion-%s", count.index)
  }
}

resource "aws_security_group" "bastion_sg" {
  count       = length(var.public_subnet_ids)
  name_prefix = "bastion-sg-"
}

resource "aws_security_group_rule" "bastion_ingress" {
  count             = length(var.public_subnet_ids)
  security_group_id = element(aws_security_group.bastion_sg.*.id, count.index)

  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
