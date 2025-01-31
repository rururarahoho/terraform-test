## --- custom gateway --- ##
resource "aws_customer_gateway" "cgw_fortinet" {
  bgp_asn    = 65000
  ip_address = var.on_premise_public_ip
  type       = "ipsec.1"

  tags = {
    Name = "${var.vpc_name}-cgw-fortinet"
  }
}

## --- virtual gateway --- ##
# create virtual gateway
resource "aws_vpn_gateway" "vgw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-vgw"
  }
}

# virtual gateway attachment
resource "aws_vpn_gateway_attachment" "vgw" {
  vpc_id         = aws_vpc.main.id
  vpn_gateway_id = aws_vpn_gateway.vgw.id
}

## --- site to site vpn --- ##
# site to site vpn create
resource "aws_vpn_connection" "site_to_site_vpn" {
  vpn_gateway_id      = aws_vpn_gateway.vgw.id
  customer_gateway_id = aws_customer_gateway.cgw_fortinet.id
  type                = "ipsec.1"
  static_routes_only  = true
  local_ipv4_network_cidr = var.on_premise_private_cidr
  remote_ipv4_network_cidr = var.aws_private_cidr
  
  tags = {
    Name = "${var.vpc_name}-site-to-site-vpn"
  }
}

# site to site vpn static route
resource "aws_vpn_connection_route" "site_to_site_vpn" {
  destination_cidr_block = var.on_premise_private_cidr
  vpn_connection_id      = aws_vpn_connection.site_to_site_vpn.id
}

# route propagation
resource "aws_vpn_gateway_route_propagation" "public" {
  vpn_gateway_id = aws_vpn_gateway.vgw.id
  route_table_id = aws_route_table.public.id
}

resource "aws_vpn_gateway_route_propagation" "private_svr" {
  vpn_gateway_id = aws_vpn_gateway.vgw.id
  route_table_id = aws_route_table.private_svr.id
}

resource "aws_vpn_gateway_route_propagation" "private_ws" {
  vpn_gateway_id = aws_vpn_gateway.vgw.id
  route_table_id = aws_route_table.private_ws.id
}

resource "aws_vpn_gateway_route_propagation" "private_rd" {
  vpn_gateway_id = aws_vpn_gateway.vgw.id
  route_table_id = aws_route_table.private_rd.id
}