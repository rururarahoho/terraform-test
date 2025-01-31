
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