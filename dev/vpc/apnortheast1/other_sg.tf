## --- EC2 Security Groups --- ##
 # EC2 Public Linux Server
resource "aws_security_group" "svr_public_linux" {
  name        = "${var.vpc_name}-default"
  description = "default group for ${var.vpc_name}"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [ "10.${var.cidr_numeral}.0.0/16" ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "${var.vpc_name}-default"
  }
}