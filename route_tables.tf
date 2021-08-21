resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Public-rtb"
  }
}

resource "aws_route" "r" {
  route_table_id            = aws_route_table.public-rtb.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.ig.id
}
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public[*].id)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public-rtb.id
}

resource "aws_route_table" "private-rtb" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Private-rtb"
  }
}
resource "aws_route" "r2" {
  route_table_id            = aws_route_table.private-rtb.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat.id
}
resource "aws_route_table_association" "private" {  
  count = length(aws_subnet.private[*].id)
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private-rtb.id
}