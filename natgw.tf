resource "aws_eip" "natgw-eip" {
  domain = "vpc"
  tags = {
    Name = "Alpha-NAT-eip"
  }
}
resource "aws_nat_gateway" "Alpha-natgw" {
  allocation_id = aws_eip.natgw-eip.id
  subnet_id     = aws_subnet.public-subnet-1a.id

  tags = {
    Name = "Alpha-NAT-GW"
  }
  depends_on = [aws_internet_gateway.alpha-gw]
}