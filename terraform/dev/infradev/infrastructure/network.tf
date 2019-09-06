module "network" {
  source = "../../../local-modules/network"

  product     = "${var.product}"
  ecosystem   = "${var.ecosystem}"
  environment = "${var.environment}"

  vpc_subnet      = "${var.vpc_subnet}"
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}
