resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnets[0]
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-public-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnets[0]
  availability_zone = var.private_subnet_az
  tags = {
    Name = "${var.project_name}-private-subnet"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}

resource "aws_eip" "nat" {
  count = var.nat_gateway ? 1 : 0
  domain = "vpc"
  tags = {
    Name = "${var.project_name}-nat-eip"
  }
}

resource "aws_nat_gateway" "main" {
  count = var.nat_gateway ? 1 : 0
  subnet_id = aws_subnet.public.id
  allocation_id = aws_eip.nat[0].id
  tags = {
    Name = "${var.project_name}-nat"
  }
}

resource "aws_route_table" "public" {
  count = var.public_route_table ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

resource "aws_route" "public" {
  count = var.public_route_table ? 1 : 0
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  count = var.public_route_table ? 1 : 0
  route_table_id = aws_route_table.public[0].id
  subnet_id      = aws_subnet.public.id
}

resource "aws_route_table" "private" {
  count = var.private_route_table ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}-private-rt"
  }
}

resource "aws_route" "private" {
  count = var.private_route_table && var.nat_gateway ? 1 : 0
  route_table_id         = aws_route_table.private[0].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main[0].id
}

resource "aws_route_table_association" "private" {
  count = var.private_subnet_association && var.private_route_table ? 1 : 0
  route_table_id = aws_route_table.private[0].id
  subnet_id      = aws_subnet.private.id
}

resource "aws_security_group" "vpc" {
  vpc_id = aws_vpc.main.id
  name   = "${var.project_name}-sg"
  description = var.security_group_description
  tags = var.tags
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}