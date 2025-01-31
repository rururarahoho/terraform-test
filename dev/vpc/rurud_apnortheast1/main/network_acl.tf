resource "aws_network_acl" "openvpn_nacl" {
  vpc_id = aws_vpc.main.id
  
  ingress {
    protocol   = "tcp"
    rule_no    = 101
    action     = "deny"
    cidr_block = var.openvpn_cluster_ip[0]
    from_port  = 445
    to_port    = 445
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 102
    action     = "deny"
    cidr_block = var.openvpn_cluster_ip[0]
    from_port  = 2049
    to_port    = 2049
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 103
    action     = "deny"
    cidr_block = var.openvpn_cluster_ip[0]
    from_port  = 998
    to_port    = 998
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 104
    action     = "deny"
    cidr_block = var.openvpn_cluster_ip[1]
    from_port  = 445
    to_port    = 445
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 105
    action     = "deny"
    cidr_block = var.openvpn_cluster_ip[1]
    from_port  = 2049
    to_port    = 2049
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 106
    action     = "deny"
    cidr_block = var.openvpn_cluster_ip[1]
    from_port  = 998
    to_port    = 998
  }

  ingress {
    protocol   = "-1"
    rule_no    = 1000
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  subnet_ids = aws_subnet.private_svr.*.id

  tags = {
    Name = "${var.vpc_name}-private_svr_acl"
  }
}