resource "aws_vpc" "module_vpc" {
  cidr_block = var.vpc-cidr-block
  tags = {
    Name = "terraform-vpc-${var.environment}"
  }
}

resource "aws_subnet" "public_subnet" {
  cidr_block = var.public-subnet-cidr
  vpc_id     = aws_vpc.module_vpc.id
  tags = {
    Name = "terraform-public-subnet-${var.environment}"
  }
}

resource "aws_subnet" "private-subnet" {
  cidr_block = var.private-subnet-cidr
  vpc_id     = aws_vpc.module_vpc.id
  tags = {
    Name = "terraform-private-subnet-${var.environment}"
  }
}
