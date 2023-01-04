resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  instance_tenancy     = "default"
  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_subnet" "backend_subnet" {
  count                   = length(data.aws_availability_zones.available.names)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.${10 + count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = "false"
  tags = {
    Name = "${var.env}-backend_subnet"
  }
}

resource "aws_subnet" "frontend_subnet" {
  count                   = length(data.aws_availability_zones.available.names)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.${20 + count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = "false"
  tags = {
    Name = "${var.env}-frontend_subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.env}-igw"
  }
}

resource "aws_eip" "nat_gtw_eip1" {
  depends_on = [
    aws_internet_gateway.igw
  ]
  vpc = true
  tags = {
    Name = "${var.env}-eip"
  }
}

resource "aws_nat_gateway" "nat_gtw" {
  depends_on = [
    aws_eip.nat_gtw_eip1
  ]
  allocation_id = aws_eip.nat_gtw_eip1.id
  subnet_id     = aws_subnet.frontend_subnet.*.id[0]
  tags = {
    Name = "${var.env}-nat_gtw"
  }
}

resource "aws_route_table" "route_to_igw_frontend" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.env}-route_to_igw"
  }
}

resource "aws_route_table" "route_to_natgtw_backend" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gtw.id
#    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.env}-route_to_nat_gateway"
  }
}

resource "aws_route_table_association" "frontend_associaton_subnet" {
  count          = length(aws_subnet.frontend_subnet)
  subnet_id      = element(aws_subnet.frontend_subnet.*.id, count.index)
  route_table_id = aws_route_table.route_to_igw_frontend.id
}

resource "aws_route_table_association" "backend_association_subnet" {
  count          = length(aws_subnet.backend_subnet)
  subnet_id      = element(aws_subnet.backend_subnet.*.id, count.index)
  route_table_id = aws_route_table.route_to_natgtw_backend.id
}

