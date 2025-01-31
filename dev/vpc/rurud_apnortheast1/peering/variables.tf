# Peering
variable "vpc_peering_request_list" {
  type = list(object({
    peer_owner_id = string
    peer_region = string
    peer_vpc_id = string
    peer_vpc_name = string
    peer_vpc_cidr = list(string)
  }))
}

variable "vpc_peering_accept_list" {
  type = list(object({
    peer_id         = string
    peer_vpc_name   = string
    peer_cidr_block = string
  }))
  description = "peering connection id for accepting the peering connection "
}