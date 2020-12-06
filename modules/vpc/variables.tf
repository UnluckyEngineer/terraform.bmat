variable "aws_region" {}
variable "cidr" {}
variable "env" {}
variable "project_name" {}
variable "domain_name_servers" {}
variable "tags" {
  type = map(string)

  default = {}
}
