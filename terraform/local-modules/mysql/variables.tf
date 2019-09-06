# Common Variables
variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "environment" {
  type = string
}

variable "ecosystem" {
  type = string
}

variable "product" {
  type = string
}

variable "vpc_id" {
  type = string
}

# RDS / DB
variable "db_instance_type" {
  type    = string
  default = "db.t2.small"
}

variable "db_subnets" {
  type = list
}

variable "db_replica_count" {
  type    = number
  default = 1
}
