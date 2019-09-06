provider "aws" {
  region  = "${var.region}"
  version = "~> 2.25"
}

provider "null" {
  version = "~> 2.1"
}

provider "random" {
  version = "~> 2.2"
}

terraform {
  backend "s3" {}
}

module "app" {
  source = "../../../../local-modules/asg-elb"

  product     = var.product
  service     = var.service
  ecosystem   = var.ecosystem
  environment = var.environment

  vpc_id     = var.vpc_id
  vpc_subnet = var.vpc_subnet

  instance_ami_id          = var.instance_ami_id
  instance_security_groups = [var.default_security_group_id]

  instance_user_data = templatefile("${path.module}/templates/userdata.sh", {
    environment = var.environment
  })

  instance_spots = var.instance_spots

  asg_subnet_ids       = var.private_subnet_ids
  asg_min_size         = var.asg_min_size
  asg_max_size         = var.asg_max_size
  asg_desired_capacity = var.asg_desired_capacity

  elb_subnets = var.public_subnet_ids

  elb_listeners = [
    {
      instance_port     = "80"
      instance_protocol = "HTTP"
      lb_port           = "80"
      lb_protocol       = "HTTP"
    },
  ]

  elb_sg_ingress_with_cidr_blocks = [
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}
