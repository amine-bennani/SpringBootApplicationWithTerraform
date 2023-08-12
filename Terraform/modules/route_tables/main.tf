resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  tags = {
    Name = format("PublicRouteTable-%s", var.env_name)
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id

  tags = {
    Name = format("PrivateRouteTable-%s", var.env_name)
  }
}

resource "aws_route" "public_subnet_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = module.subnets.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = module.subnets.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private_route_table.id
}
