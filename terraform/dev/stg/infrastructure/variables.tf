variable "region" {
  type = string
}

variable "product" {
  type = string
}

variable "ecosystem" {
  type = string
}

variable "environment" {
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
