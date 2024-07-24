resource "aws_subnet" "public-subnet-1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.1.0.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = var.AZ1-public-subnet_name
  }
}
resource "aws_subnet" "public-subnet-1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = var.AZ2-public-subnet_name
  }
}
resource "aws_subnet" "private-subnet-1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = var.AZ1-private-subnet_name
  }
}
resource "aws_subnet" "private-subnet-1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.1.3.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = var.AZ2-private-subnet_name
  }
}