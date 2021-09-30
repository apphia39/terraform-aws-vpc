###################################
# Create the VPC
###################################
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc"
  }
}

###################################
# Create the Subnets
###################################
resource "aws_subnet" "public_subnet" {
  count             = 2
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.availability_zone[count.index]
  cidr_block        = var.cidr_public_subnet[count.index]

  tags = {
    Name = "public_subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = 2
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.cidr_private_subnet[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = "private_subnet"
  }
}

###################################
# Create the GATEWAY
###################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw"
  }
}

###################################
# Create the Route Tables
###################################
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.cidr_igw
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "private_rt"
  }
}

###################################
# Connect route tables with subnets
###################################
resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private" {
  count          = 2
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt.id
}
