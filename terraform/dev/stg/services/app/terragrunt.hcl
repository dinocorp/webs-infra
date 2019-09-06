dependency "infrastructure" {
  config_path = "../../infrastructure"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  # Common to all services in this environment
  environment               = dependency.infrastructure.outputs.environment
  vpc_id                    = dependency.infrastructure.outputs.vpc_id
  vpc_subnet                = dependency.infrastructure.outputs.vpc_subnet
  private_subnet_ids        = dependency.infrastructure.outputs.private_subnet_ids
  public_subnet_ids         = dependency.infrastructure.outputs.public_subnet_ids
  private_subnets           = dependency.infrastructure.outputs.private_subnets
  public_subnets            = dependency.infrastructure.outputs.public_subnets
  default_security_group_id = dependency.infrastructure.outputs.default_security_group_id

  # Service / environment specific vars
  service = "app"

  instance_ami_id = "ami-01cca82393e531118" # Ubuntu LTS Latest
  instance_spots  = false

  asg_min_size         = 1
  asg_max_size         = 3
  asg_desired_capacity = 3
}
