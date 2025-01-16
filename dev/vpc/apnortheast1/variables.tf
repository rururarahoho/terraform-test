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

