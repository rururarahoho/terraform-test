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