###################################
# Create the VPC
###################################
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

###################################
# Create the Subnets
###################################
resource "aws_subnet" "public_subnet" {
  count             = var.subnet_num
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.subnet_az[count.index]
  cidr_block        = var.public_subnet_cidrs[count.index]

  tags = {
    Name = var.public_name
  }
}

resource "aws_subnet" "private_subnet" {
  count             = var.subnet_num
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.subnet_az[count.index]

  tags = {
    Name = var.private_name
  }
}

###################################
# Create the GATEWAY
###################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.igw_name
  }
}

###################################
# Create the Route Tables
###################################
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.igw_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.public_name}-rt"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.private_name}-rt"
  }
}

###################################
# Connect route tables with subnets
###################################
resource "aws_route_table_association" "public" {
  count          = var.subnet_num
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private" {
  count          = var.subnet_num
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt.id
}
