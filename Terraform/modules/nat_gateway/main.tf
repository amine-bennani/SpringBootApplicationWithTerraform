resource "aws_nat_gateway" "nat_gateways" {
  count      = length(var.public_subnet_ids)
  subnet_id  = element(var.public_subnet_ids, count.index)
  allocation_id = element(aws_eip.nat_eips.*.id, count.index)

  tags = {
    Name = format("NATGateway-%s", count.index)
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_eip" "nat_eips" {
  count = length(var.public_subnet_ids)
  tags = {
    Name = format("NATGateway-EIP-%s", count.index)
  }
}
