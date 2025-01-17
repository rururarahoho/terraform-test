# Default Security Group 
# This is the security group for most of instances should have 
resource "aws_security_group" "default" {
  name        = "${var.vpc_name}-default"
  description = "default group for ${var.vpc_name}"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    description = "local network"
    cidr_blocks = [ "10.${var.cidr_numeral}.0.0/16" ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    description = "local network"
    cidr_blocks = [ "10.${var.cidr_numeral}.0.0/16" ]
  }

  tags = {
    Name = "${var.vpc_name}-default"
  }
}

# Endpoint Default Security Group
resource "aws_security_group" "endpoint_default" {
  name        = "${var.vpc_name}-endpoint-default"
  description = "endpoint default group for ${var.vpc_name}"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    description = "local network"
    cidr_blocks = [ "10.${var.cidr_numeral}.0.0/16" ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    description = "local network"
    cidr_blocks = [ "10.${var.cidr_numeral}.0.0/16" ]
  }

  tags = {
    Name = "${var.vpc_name}-endpoint-default"
  }
}

# All allow Security Group
resource "aws_security_group" "all_allow" {
  name        = "${var.vpc_name}-all-allow"
  description = "endpoint default group for ${var.vpc_name}"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    description = "all network"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    description = "all network"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "${var.vpc_name}-all-allow"
  }
}