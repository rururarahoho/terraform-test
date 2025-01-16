## --- EC2 Security Groups --- ##
 # EC2 Public Linux Server
resource "aws_security_group" "svr_public_linux" {
  name        = "${var.vpc_name}-svr_public_linux"
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

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "${var.vpc_name}-svr_public_linux"
  }
}

# EC2 Private Linux Server
resource "aws_security_group" "svr_private_linux" {
  name        = "${var.vpc_name}-svr_private_linux"
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
  tags = {
    Name = "${var.vpc_name}-svr_private_linux"
  }
}