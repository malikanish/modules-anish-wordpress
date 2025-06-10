
### VPC-START ###

resource "aws_vpc" "anish_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${var.prefix_name}-${var.vpc_name}-${var.prefix_env}"
  }
}


### VPC-END ###

### VPC-public-subnet ###


resource "aws_subnet" "public_subnets" {
  count                   = var.subnet_count
  vpc_id                  = aws_vpc.anish_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index % length(data.aws_availability_zones.available.names))
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.prefix_name}-${var.public_subnet_name}-${var.prefix_env}-${count.index + 1}"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.anish_vpc.id

  tags = {
    Name = "${var.prefix_name}-${var.igw_name}-${var.prefix_env}"
  }
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.anish_vpc.id

  route {
    cidr_block = var.default_route
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.prefix_name}-${var.route_table_name}-${var.prefix_env}"
  }
}

resource "aws_route_table_association" "public_subnet_associations" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rtb.id
}



### VPC-public-subnet-END ###


### VPC- private-subnets start ###
resource "aws_subnet" "private_subnets" {
  count             = var.subnet_count
  vpc_id            = aws_vpc.anish_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, count.index + var.subnet_count)
  availability_zone = element(data.aws_availability_zones.available.names, count.index % length(data.aws_availability_zones.available.names))

  tags = {
    Name = "${var.prefix_name}-${var.private_subnet_name}-${var.prefix_env}-${count.index + 1}"
  }
}


### VPC-private-subnets END###


resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "${var.prefix_name}-${var.eip_name}-${var.prefix_env}"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name = "${var.prefix_name}-${var.nat_gateway_name}-${var.prefix_env}"
  }

  depends_on = [aws_internet_gateway.igw]
}
resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.anish_vpc.id

  route {
    cidr_block     = var.default_route
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "${var.prefix_name}-${var.private_route_table_name}-${var.prefix_env}"
  }
}
resource "aws_route_table_association" "private_subnet_associations" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rtb.id
}

