## --- EC2 Security Groups --- ##
 # EC2 Public Server
resource "aws_security_group" "svr_public" {
  name        = "${var.vpc_name}-svr_public"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [ "10.${var.cidr_numeral}.0.0/16" ]
    description = "local network"
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "OpenVPN AS"
  }

  ingress {
    from_port = 943
    to_port   = 943
    protocol  = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "OpenVPN AS"
  }

  ingress {
    from_port = 1194
    to_port   = 1194
    protocol  = "udp"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "OpenVPN AS"
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "SSH"
  }

  ingress {
    from_port = 3389
    to_port   = 3389
    protocol  = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "RDP"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "${var.vpc_name}-svr_public"
  }
}

# EC2 Private Server
resource "aws_security_group" "svr_private" {
  name        = "${var.vpc_name}-svr_private"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [ "10.${var.cidr_numeral}.0.0/16" ]
    description = "local network"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [ "10.${var.cidr_numeral}.0.0/16" ]
    description = "local network"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    prefix_list_ids   = [aws_vpc_endpoint.s3.prefix_list_id]
    description = "s3 endpoint"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    prefix_list_ids   = [aws_vpc_endpoint.dynamodb.prefix_list_id]
    description = "dynamodb endpoint"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    prefix_list_ids   = [aws_ec2_managed_prefix_list.iam.dynamodb.id]
    description = "iam prefix list"
  }

  tags = {
    Name = "${var.vpc_name}-svr_private"
  }
}

# EC2 Private WS
resource "aws_security_group" "ws_private" {
  name        = "${var.vpc_name}-ws_private"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [ "10.${var.cidr_numeral}.0.0/16" ]
    description = "local network"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [ "10.${var.cidr_numeral}.0.0/16" ]
    description = "local network"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    prefix_list_ids   = [aws_vpc_endpoint.s3.prefix_list_id]
    description = "s3 endpoint"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    prefix_list_ids   = [aws_vpc_endpoint.dynamodb.prefix_list_id]
    description = "dynamodb endpoint"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    prefix_list_ids   = [aws_ec2_managed_prefix_list.iam.dynamodb.id]
    description = "iam prefix list"
  }

  tags = {
    Name = "${var.vpc_name}-ws_private"
  }
}

# EC2 Private RD
resource "aws_security_group" "rd_private" {
  name        = "${var.vpc_name}-rd_private"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [ "10.${var.cidr_numeral}.0.0/16" ]
    description = "local network"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [ "10.${var.cidr_numeral}.0.0/16" ]
    description = "local network"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    prefix_list_ids   = [aws_vpc_endpoint.s3.prefix_list_id]
    description = "s3 endpoint"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    prefix_list_ids   = [aws_vpc_endpoint.dynamodb.prefix_list_id]
    description = "dynamodb endpoint"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    prefix_list_ids   = [aws_ec2_managed_prefix_list.iam.dynamodb.id]
    description = "iam prefix list"
  }

  tags = {
    Name = "${var.vpc_name}-rd_private"
  }
}