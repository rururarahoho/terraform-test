variable "aws_region" {
  description = "region"
}

variable "vpc_name" {
  description = "The name of the VPC"
}

variable "availability_zones" {
  type = list(string)
  description = "AZ of the VPC"
}