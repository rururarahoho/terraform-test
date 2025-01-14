resource "aws_vpc" "default" {
  cidr_block           = "10.20.0.0/16" # Please set this according to your company size
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-thessen"
  }
}

