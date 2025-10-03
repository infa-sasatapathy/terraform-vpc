resource "aws_vpc" "production" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name        = "Production"
    Environment = var.environment
  }
}

# Public Subnets
resource "aws_subnet" "public-subnet-1" {
  cidr_block        = var.public_subnet_1_cidr
  vpc_id            = aws_vpc.production.id
  availability_zone = "${var.region}a"

  tags = {
    Name        = "Public-Subnet-1"
    Environment = var.environment
  }
}

resource "aws_subnet" "public-subnet-2" {
  cidr_block        = var.public_subnet_2_cidr
  vpc_id            = aws_vpc.production.id
  availability_zone = "${var.region}b"

  tags = {
    Name        = "Public-Subnet-2"
    Environment = var.environment
  }
}

resource "aws_subnet" "public-subnet-3" {
  cidr_block        = var.public_subnet_3_cidr
  vpc_id            = aws_vpc.production.id
  availability_zone = "${var.region}c"

  tags = {
    Name        = "Public-Subnet-3"
    Environment = var.environment
  }
}

# Private Subnets
resource "aws_subnet" "private-subnet-1" {
  cidr_block        = var.private_subnet_1_cidr
  vpc_id            = aws_vpc.production.id
  availability_zone = "${var.region}a"

  tags = {
    Name        = "Private-Subnet-1"
    Environment = var.environment
  }
}

resource "aws_subnet" "private-subnet-2" {
  cidr_block        = var.private_subnet_2_cidr
  vpc_id            = aws_vpc.production.id
  availability_zone = "${var.region}b"

  tags = {
    Name        = "Private-Subnet-2"
    Environment = var.environment
  }
}

resource "aws_subnet" "private-subnet-3" {
  cidr_block        = var.private_subnet_3_cidr
  vpc_id            = aws_vpc.production.id
  availability_zone = "${var.region}c"

  tags = {
    Name        = "Private-Subnet-3"
    Environment = var.environment
  }
}

# Route Tables
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.production.id
  tags = {
    Name        = "Public-Route-Table"
    Environment = var.environment
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.production.id
  tags = {
    Name        = "Private-Route-Table"
    Environment = var.environment
  }
}

# Associations
resource "aws_route_table_association" "public-1" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-1.id
}
resource "aws_route_table_association" "public-2" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-2.id
}
resource "aws_route_table_association" "public-3" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-3.id
}

resource "aws_route_table_association" "private-1" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private-subnet-1.id
}
resource "aws_route_table_association" "private-2" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private-subnet-2.id
}
resource "aws_route_table_association" "private-3" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private-subnet-3.id
}

# IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.production.id
  tags = {
    Name        = "Production-IGW"
    Environment = var.environment
  }
}

# EIP for NAT
resource "aws_eip" "eip" {
  associate_with_private_ip = "192.168.0.5"
  tags = {
    Name        = "Production-EIP"
    Environment = var.environment
  }
}

# NAT Gateway
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public-subnet-1.id
  depends_on    = [aws_eip.eip]

  tags = {
    Name        = "Production-NAT-GW"
    Environment = var.environment
  }
}

# Routes
resource "aws_route" "public-internet" {
  route_table_id         = aws_route_table.public-route-table.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "private-nat" {
  route_table_id         = aws_route_table.private-route-table.id
  nat_gateway_id         = aws_nat_gateway.nat-gw.id
  destination_cidr_block = "0.0.0.0/0"
}
