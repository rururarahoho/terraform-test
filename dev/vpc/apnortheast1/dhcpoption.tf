## --- DHCP Option Set --- ###
resource "aws_vpc_dhcp_options" "dhcp_option" {
    domain_name = var.domain_name
    domain_name_servers = var.domain_name_servers
    
    tags = {
        Name = "${var.vpc_name}-${var.domain_name}-dhcp"
    }
}

# DHCP Option Set association
resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = aws_vpc.main.id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp_option.id
}