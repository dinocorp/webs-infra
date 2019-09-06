module "ec2_spot" {
  source        = "../ec2_spot_prices"
  instance_type = var.instance_spots ? var.instance_type : ""
}

module "this_asg" {
  source = "../../vendor/xterrafile/aws-asg"

  name = "${var.product}-${var.environment}-${var.service}"

  lc_name = "${var.product}-${var.environment}-${var.service}"

  image_id      = var.instance_ami_id
  instance_type = var.instance_type
  user_data     = var.instance_user_data
  spot_price    = module.ec2_spot.price

  security_groups = concat([module.this_instance_sg.this_security_group_id], var.instance_security_groups)
  load_balancers  = [module.this_elb.this_elb_id]

  associate_public_ip_address = false

  root_block_device = [{
    volume_size = var.instance_root_disk_size
    volume_type = var.instance_root_device_type
  }]

  ebs_block_device = var.instance_ebs_block_device

  # Auto scaling group
  asg_name                  = "${var.product}-${var.environment}-${var.service}"
  vpc_zone_identifier       = var.asg_subnet_ids
  health_check_type         = var.asg_health_check_type
  min_size                  = var.asg_min_size
  max_size                  = var.asg_max_size
  desired_capacity          = var.asg_desired_capacity
  wait_for_capacity_timeout = var.asg_wait_for_capacity_timeout

  tags_as_map = {
    Terraform   = "true"
    Environment = var.environment
    Ecosystem   = var.ecosystem
    Service     = var.service
    Product     = var.product
  }
}

module "this_elb" {
  source = "../../vendor/xterrafile/aws-elb"

  name = "${var.product}-${var.environment}-${var.service}"

  subnets         = var.elb_subnets
  security_groups = [module.this_elb_sg.this_security_group_id]
  internal        = var.elb_internal

  listener = var.elb_listeners

  health_check = var.elb_healthcheck

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Ecosystem   = var.ecosystem
    Service     = var.service
    Product     = var.product
  }
}

module "this_elb_sg" {
  source = "../../vendor/xterrafile/aws-security-group"

  name   = "${var.product}-${var.environment}-${var.service}-elb"
  vpc_id = var.vpc_id

  ingress_with_cidr_blocks      = var.elb_sg_ingress_with_cidr_blocks
  ingress_with_ipv6_cidr_blocks = var.elb_sg_ingress_with_ipv6_cidr_blocks

  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = var.vpc_subnet
    },
  ]

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Ecosystem   = var.ecosystem
    Service     = var.service
    Product     = var.product
  }
}

module "this_instance_sg" {
  source = "../../vendor/xterrafile/aws-security-group"

  name   = "${var.product}-${var.environment}-${var.service}-instance"
  vpc_id = var.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "all-all"
      source_security_group_id = module.this_elb_sg.this_security_group_id
    },
  ]

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Ecosystem   = var.ecosystem
    Service     = var.service
    Product     = var.product
  }
}
