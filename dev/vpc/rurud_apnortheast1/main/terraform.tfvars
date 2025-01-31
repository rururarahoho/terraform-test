# VPC Main Variables
shard_id = "testapne1"
aws_region = "ap-northeast-1"
vpc_name = "main_apnortheast1"
cidr_numeral = "20"
availability_zones = ["ap-northeast-1a","ap-northeast-1c","ap-northeast-1d"]
cidr_numeral_public = {
    "0" = "0"
    "1" = "4"
    "2" = "8"
#    "3" = "12"
}
cidr_numeral_private_svr = {
    "0" = "24"
    "1" = "28"
    "2" = "32"
#    "3" = "36"
}

cidr_numeral_private_ws = {
    "0" = "48"
    "1" = "52"
    "2" = "60"
#    "3" = "64"
}

cidr_numeral_private_rd = {
    "0" = "72"
    "1" = "80"
    "2" = "88"
#    "3" = "96"
}

# Site to Site VPN Variable
on_premise_public_ip = "211.243.118.210"
on_premise_private_cidr = "192.168.30.0/24"
aws_private_cidr = "10.${cidr_numeral}.0.0/16"

# DHCP Option Set
domain_name = "lion.com"
domain_name_servers = ["10.20.24.12", "10.20.24.13"]

# Network ACL
openvpn_cluster_ip = ["10.20.0.5/32", "10.20.0.6/32"]

# VPC Peering Requester
vpc_peering_request_list = [
    {
        peer_owner_id = "657678323470"
        peer_region   = "ap-northeast-1"
        peer_vpc_cidr = [ "10.30.0.0/16" ]
        peer_vpc_id   = "vpc-"
        peer_vpc_name = "sub_apnortheast1"
    }
]

# VPC Peering Accepter
vpc_peering_accept_list = [
  {
    "peer_id"         = "pcx-025501a85c5371c20"
    "peer_vpc_name"   = "main_apnortheast2"
    "peer_cidr_block" = "10.10.0.0/16"
  }
]