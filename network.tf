resource "aws_vpc" "vpc1" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc1"
  }
}

resource "aws_subnet" "subnet_privada1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.private_subnet
  availability_zone       = var.vpc_aws_az
  map_public_ip_on_launch = "true"
  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "subnet_privada2" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.private_subnet-2
  availability_zone       = var.vpc_aws_az-2
  map_public_ip_on_launch = "true"
  tags = {
    Name = "subnet2"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "gw1"
  }
}

resource "aws_default_route_table" "defaultR" {
  default_route_table_id = aws_vpc.vpc1.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "defaultR"
  }
}



