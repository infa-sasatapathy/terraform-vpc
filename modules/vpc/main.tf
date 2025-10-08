###################################
# 1️⃣  VPC
###################################
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.vpc_name}"
    Environment = var.environment
  }
}

###################################
# 2️⃣  DATA SOURCE FOR AZs
###################################
data "aws_availability_zones" "available" {}

###################################
# 3️⃣  INTERNET GATEWAY
###################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.vpc_name}-igw"
    Environment = var.environment
  }
}

###################################
# 4️⃣  PUBLIC SUBNETS
###################################
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name        = "${var.vpc_name}-public-${count.index + 1}"
    Environment = var.environment
  }
}

###################################
# 5️⃣  PRIVATE SUBNETS
###################################
resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name        = "${var.vpc_name}-private-${count.index + 1}"
    Environment = var.environment
  }
}

###################################
# 6️⃣  ELASTIC IPs + NAT GATEWAYS (1 per AZ)
###################################
resource "aws_eip" "nat" {
  count = length(var.public_subnets)

  tags = {
    Name        = "${var.vpc_name}-nat-eip-${count.index + 1}"
    Environment = var.environment
  }
}

resource "aws_nat_gateway" "nat" {
  count         = length(var.public_subnets)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  depends_on    = [aws_internet_gateway.igw]

  tags = {
    Name        = "${var.vpc_name}-nat-gw-${count.index + 1}"
    Environment = var.environment
  }
}

###################################
# 7️⃣  ROUTE TABLES (Public + Private per AZ)
###################################
# One Public RT for all public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.vpc_name}-public-rt"
    Environment = var.environment
  }
}

# One Private RT per private subnet (to route to each NAT)
resource "aws_route_table" "private" {
  count  = length(var.private_subnets)
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.vpc_name}-private-rt-${count.index + 1}"
    Environment = var.environment
  }
}

###################################
# 8️⃣  ROUTES
###################################
# Public Subnets → Internet Gateway
resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}

# Private Subnets → Respective NAT Gateway
resource "aws_route" "private_nat_route" {
  count                  = length(var.private_subnets)
  route_table_id         = aws_route_table.private[count.index].id
  nat_gateway_id         = aws_nat_gateway.nat[count.index].id
  destination_cidr_block = "0.0.0.0/0"
}

###################################
# 9️⃣  ROUTE TABLE ASSOCIATIONS
###################################
# Public subnets to Public RT
resource "aws_route_table_association" "public_assoc" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Private subnets to their Private RT (same index)
resource "aws_route_table_association" "private_assoc" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
