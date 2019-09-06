include {
  path = find_in_parent_folders()
}

inputs = {
  environment = "stg"

  vpc_subnet      = "172.21.0.0/16"
  public_subnets  = ["172.21.0.0/24", "172.21.2.0/24", "172.21.4.0/24"]
  private_subnets = ["172.21.1.0/24", "172.21.3.0/24", "172.21.5.0/24"]
}
