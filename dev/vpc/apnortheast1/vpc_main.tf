resource "aws_vpc" "main" {
  cidr_block           = "10.${var.cidr_numeral}.0.0/16" # Please set this according to your company size
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-${var.vpc_name}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-${var.vpc_name}"
  }
}

## NAT Gateway



# Elastic IP for NAT Gateway 
resource "aws_eip" "nat" {
  for_each = var.availability_zones
  domain = "vpc"
  
  tags = {
    Name = "ngw-eip-${each.key}"
  }

  lifecycle {
    create_before_destroy = true
  }
}