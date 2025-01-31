# VPC Main Variables
variable "shard_id" {
  description = "distinguish resource"
}

variable "aws_region" {
  description = "region"
}

variable "vpc_name" {
  description = "The name of the VPC"
}

variable "cidr_numeral" {
  description = "The VPC CIDR numeral (10.x.0.0/16)"
}

variable "availability_zones" {
  type = list(string)
  description = "AZs of the VPC"
}

variable "cidr_numeral_public" {
  type = map(string)
}

variable "cidr_numeral_private_svr" {
  type = map(string)
}

variable "cidr_numeral_private_ws" {
  type = map(string)
}

variable "cidr_numeral_private_rd" {
  type = map(string)
}

# Site to Site VPN Variable
variable "on_premise_public_ip" {
  type = string
}

variable "on_premise_private_cidr" {
  type = string
}

variable "aws_private_cidr" {
  type = string
}

# DHCP Option Set
variable "domain_name" {
  type = string
}

variable "domain_name_servers" {
  type = list(string)
}

# Netwok ACL
variable "openvpn_cluster_ip" {
  type = list(string)
}

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