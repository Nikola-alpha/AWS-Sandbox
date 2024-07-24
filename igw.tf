resource "aws_internet_gateway" "alpha-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "var.VPC_name"
  }
}