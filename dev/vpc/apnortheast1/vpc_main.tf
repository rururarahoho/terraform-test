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
        Name = "public-${var.availability_zones[count.index]}"
    }
}

# private server subnet
resource "aws_subnet" "private_svr" {
    count = length(var.availability_zones)

    vpc_id = aws_vpc.main.id
    cidr_block = "10.${var.cidr_numeral}.${var.cidr_numeral_private_svr[count.index]}.0/22"
    availability_zone = element(var.availability_zones, count.index)
    tags = {
        Name = "private-svr-${var.availability_zones[count.index]}"
    }
}

# private ws subnet
resource "aws_subnet" "private_ws" {
    count = length(var.availability_zones)

    vpc_id = aws_vpc.main.id
    cidr_block = "10.${var.cidr_numeral}.${var.cidr_numeral_private_ws[count.index]}.0/22"
    availability_zone = element(var.availability_zones, count.index)
    tags = {
        Name = "private-ws-${var.availability_zones[count.index]}"
    }
}

# private rd subnet
resource "aws_subnet" "private_rd" {
    count = length(var.availability_zones)

    vpc_id = aws_vpc.main.id
    cidr_block = "10.${var.cidr_numeral}.${var.cidr_numeral_private_rd[count.index]}.0/21"
    availability_zone = element(var.availability_zones, count.index)
    tags = {
        Name = "private-rd-${var.availability_zones[count.index]}"
    }
}
