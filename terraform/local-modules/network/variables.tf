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

variable "vpc_subnet" {
  type = string
}

variable "public_subnets" {
  type = list
}

variable "private_subnets" {
  type = list
}
