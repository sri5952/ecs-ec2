# VPC configuration
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "lessons-mgmt"
  }
}

# Public subnet 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_1_cidr_block
  availability_zone       = var.subnet_az_1
  map_public_ip_on_launch = true

  tags = {
    Name = "lessons-mgmt-publicsubnet-1"
  }
}

# Public subnet 2
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_2_cidr_block
  availability_zone       = var.subnet_az_2
  map_public_ip_on_launch = true

  tags = {
    Name = "lessons-mgmt-publicsubnet-2"
  }
}

# Private subnet 1
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_1_cidr_block
  availability_zone = var.subnet_az_1

  tags = {
    Name = "lessons-mgmt-privatetesubnet-1"
  }

}

# Private subnet 2
resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_2_cidr_block
  availability_zone = var.subnet_az_2

  tags = {
    Name = "lessons-mgmt-privatetesubnet-2"
  }

}

/*
# Private subnet 3
resource "aws_subnet" "private_subnet_3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_3_cidr_block
  availability_zone = var.subnet_az_1

}

# Private subnet 4
resource "aws_subnet" "private_subnet_4" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_4_cidr_block
  availability_zone = var.subnet_az_2

}

*/

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "lessons-mgmt-igw"
  }
}

# Route table for public subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "lessons-mgmt-publicroutetable"
  }
}

# Assign public route table to public subnet 1
resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

# Assign public route table to public subnet 2
resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

# Route table for private subnets
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "lessons-mgmt-privateroutetable"
  }
}

# Assign private route table to private subnet 1
resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

# Assign private route table to private subnet 2
resource "aws_route_table_association" "private_assoc_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}

/*
# Assign private route table to private subnet 3
resource "aws_route_table_association" "private_assoc_3" {
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.private_route_table.id
}

# Assign private route table to private subnet 4
resource "aws_route_table_association" "private_assoc_4" {
  subnet_id      = aws_subnet.private_subnet_4.id
  route_table_id = aws_route_table.private_route_table.id
}

*/