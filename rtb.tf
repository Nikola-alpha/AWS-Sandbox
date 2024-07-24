resource "aws_route_table" "Alpha-pub-rtb" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.alpha-gw.id
  }

  tags = {
    Name = "route-to-public-via-IGW"
  }
}
resource "aws_route_table" "Alpha-priv-rtb" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.Alpha-natgw.id
  }

  tags = {
    Name = "route-to-public-via-NATGW"
  }
}
resource "aws_route_table_association" "AZ1-Alpha-pub-rtb-association" {
  subnet_id      = aws_subnet.public-subnet-1a.id
  route_table_id = aws_route_table.Alpha-pub-rtb.id
}
resource "aws_route_table_association" "AZ2-Alpha-pub-rtb-association" {
  subnet_id      = aws_subnet.public-subnet-1b.id
  route_table_id = aws_route_table.Alpha-pub-rtb.id
}
resource "aws_route_table_association" "AZ1-Alpha-priv-rtb-association" {
  subnet_id      = aws_subnet.private-subnet-1a.id
  route_table_id = aws_route_table.Alpha-priv-rtb.id
}
resource "aws_route_table_association" "AZ2-Alpha-priv-rtb-association" {
  subnet_id      = aws_subnet.private-subnet-1b.id
  route_table_id = aws_route_table.Alpha-priv-rtb.id
}