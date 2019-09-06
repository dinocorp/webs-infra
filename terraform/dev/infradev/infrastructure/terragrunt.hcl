include {
  path = find_in_parent_folders()
}

inputs = {
  environment = "infradev"

  vpc_subnet      = "172.20.0.0/16"
  public_subnets  = ["172.20.0.0/24", "172.20.2.0/24", "172.20.4.0/24"]
  private_subnets = ["172.20.1.0/24", "172.20.3.0/24", "172.20.5.0/24"]
}
