# Common variables
variable "vpc_id" {
  type = string
}

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

variable "service" {
  type = string
}

variable "vpc_subnet" {
  type = string
}

variable "private_subnet_ids" {
  type = list
}

variable "public_subnet_ids" {
  type = list
}

# ASG / LC variables
variable "instance_ami_id" {
  type = string
}

variable "instance_spots" {
  type    = bool
  default = false
}

variable "default_security_group_id" {
  type = string
}

variable "asg_min_size" {
  type = number
}

variable "asg_max_size" {
  type = number
}

variable "asg_desired_capacity" {
  type = number
}
