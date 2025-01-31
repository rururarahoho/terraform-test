## --- vpc --- ##
resource "aws_vpc" "main" {
    cidr_block = "10.${var.cidr_numeral}.0.0/16"
    enable_dns_hostnames = true

    tags = {
        Name = "${var.vpc_name}"
    }
}

## --- subnet --- ##
# public subnet
resource "aws_subnet" "public" {
    count = length(var.availability_zones)

    vpc_id = aws_vpc.main.id
    cidr_block = "10.${var.cidr_numeral}.${var.cidr_numeral_public[count.index]}.0/22"
    availability_zone = element(var.availability_zones, count.index)
    tags = {
        Name = "${var.vpc_name}-public-${var.availability_zones[count.index]}"
    }
}

# private server subnet
resource "aws_subnet" "private_svr" {
    count = length(var.availability_zones)

    vpc_id = aws_vpc.main.id
    cidr_block = "10.${var.cidr_numeral}.${var.cidr_numeral_private_svr[count.index]}.0/22"
    availability_zone = element(var.availability_zones, count.index)
    tags = {
        Name = "${var.vpc_name}-private-svr-${var.availability_zones[count.index]}"
    }
}

# private ws subnet
resource "aws_subnet" "private_ws" {
    count = length(var.availability_zones)

    vpc_id = aws_vpc.main.id
    cidr_block = "10.${var.cidr_numeral}.${var.cidr_numeral_private_ws[count.index]}.0/22"
    availability_zone = element(var.availability_zones, count.index)
    tags = {
        Name = "${var.vpc_name}-private-ws-${var.availability_zones[count.index]}"
    }
}

# private rd subnet
resource "aws_subnet" "private_rd" {
    count = length(var.availability_zones)

    vpc_id = aws_vpc.main.id
    cidr_block = "10.${var.cidr_numeral}.${var.cidr_numeral_private_rd[count.index]}.0/21"
    availability_zone = element(var.availability_zones, count.index)
    tags = {
        Name = "${var.vpc_name}-private-rd-${var.availability_zones[count.index]}"
    }
}

## --- routing table --- ##
# public
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "${var.vpc_name}-public-rt"
    }
}

# private svr
resource "aws_route_table" "private_svr" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "${var.vpc_name}-private-svr-rt"
    }
}

# private ws
resource "aws_route_table" "private_ws" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "${var.vpc_name}-private-ws-rt"
    }
}

# private rd
resource "aws_route_table" "private_rd" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "${var.vpc_name}-private-rd-rt"
    }
}

## --- route table association subnet --- ##
# public
resource "aws_route_table_association" "public" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

# private svr
resource "aws_route_table_association" "private_svr" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.private_svr.*.id, count.index)
  route_table_id = aws_route_table.private_svr.id
}

# private ws
resource "aws_route_table_association" "private_ws" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.private_ws.*.id, count.index)
  route_table_id = aws_route_table.private_ws.id
}

# private rd
resource "aws_route_table_association" "private_rd" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.private_rd.*.id, count.index)
  route_table_id = aws_route_table.private_rd.id
}

## --- internet gateway --- ##
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

## --- routing internet gateway --- ##
# public
resource "aws_route" "igw" {
    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}
