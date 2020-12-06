variable "vpc_id" {
  type = string
}

variable "env" {
  type = string
}

variable "az" {
  type = list
}

variable "redis_name" {
  type = string
}

variable "sg_redis_ids" {
  type = list
}

variable "parameter_group" {
  type = string

  default = "default.redis3.2"
}

variable "subnet_ids" {
  type = list
}

#variable "subnet_ids" {
#  type = string
#}

variable "desired_clusters" {
  type = string

  default = "1"
}

variable "instance_type" {
  type = string

  default = "cache.t2.micro"
}

variable "engine_version" {
  type = string

  default = "3.2.4"
}

variable "automatic_failover_enabled" {
  default = false
}

variable "tags" {
  type = map
  default = {}
}

variable "new_parameter_group_name" {
  default = ""
}

variable "new_parameter_group_family" {
  default = ""
}

variable "new_parameter_group_params" {
  type = map
  default = {}
}

variable "snapshot_retention_days" {
  type = string

  default = "0"
}

variable "snapshot_window" {
  type = string

  default = "01:00-02:00"
}

variable "encryption_enabled" {
  default = false
}