variable "env" {}

variable "vpc_id" {}

variable "project_name" {}

variable "authorized_ips" {
  type = map

  default = {}
}

variable "tags" {
  type = map

  default = {}
}
