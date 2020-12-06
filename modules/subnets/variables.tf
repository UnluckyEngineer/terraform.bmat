variable "vpc_id" {}

variable "gw_id" {}

variable "env" {}

variable "aws_region" {}

variable "project_name" {}

variable "availablity_zones" {}

variable "public_subnets_cidr" {
  default = ""
}

variable "private_subnets_cidr" {
  default = ""
}

variable "nat_gateway_enabled" {
  default = 0
}

variable "vpc_peering_destination_cidr_block" {
  default = ""
}

variable "vpc_peering_id" {
  default = ""
}

variable "tags" {
  type = map(string)

  default = {}
}
