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

variable "service" {
  type = string
}

variable "vpc_id" {
  type = string
}

# ASG / LC Variables
variable "instance_ami_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_root_disk_size" {
  type    = number
  default = 10
}

variable "instance_root_device_type" {
  type    = string
  default = "standard"
}

variable "instance_ebs_block_device" {
  type    = list
  default = []
}

variable "instance_security_groups" {
  type    = list
  default = []
}

variable "instance_user_data" {
  type    = string
  default = "true"
}

variable "instance_spots" {
  type    = bool
  default = false
}

variable "instance_associate_public_ip" {
  type    = bool
  default = false
}

variable "asg_subnet_ids" {
  type    = list
  default = []
}

variable "asg_health_check_type" {
  type    = string
  default = "EC2"
}

variable "asg_min_size" {
  type    = number
  default = 0
}

variable "asg_max_size" {
  type    = number
  default = 0
}

variable "asg_desired_capacity" {
  type    = number
  default = 0
}

variable "asg_wait_for_capacity_timeout" {
  type    = string
  default = "300s"
}

# Security Group
variable "sg_ingress_with_cidr_blocks" {
  type    = list
  default = []
}

variable "sg_ingress_with_ipv6_cidr_blocks" {
  type    = list
  default = []
}
