module "this_vpc" {
  source = "../../vendor/xterrafile/aws-vpc"

  name = "${var.product}-${var.environment}-vpc"
  cidr = var.vpc_subnet

  azs             = data.aws_availability_zones.available.names
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway     = true
  one_nat_gateway_per_az = true

  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Ecosystem   = var.ecosystem
    Product     = var.product
  }
}

# To start with, we will only allow SSH to all instances
module "this_sg" {
  source = "../../vendor/xterrafile/aws-security-group//modules/ssh"

  name        = "${var.product}-${var.environment}-default"
  description = "Allow TCP 22 in VPC for ${var.product}-${var.environment} instances"
  vpc_id      = module.this_vpc.vpc_id

  ingress_cidr_blocks = [var.vpc_subnet]

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Ecosystem   = var.ecosystem
  }
}
