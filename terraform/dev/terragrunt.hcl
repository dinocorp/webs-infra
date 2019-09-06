skip = true

locals {
  org        = "dinocorp"
  product    = "webs"
  aws_region = "eu-west-1"
  ecosystem  = "dev"
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "${local.org}-terraform-state"
    region         = local.aws_region
    key            = "${local.product}/${local.ecosystem}/${path_relative_to_include()}/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "${local.org}-terraform-lock"
  }
}

inputs = {
  org        = local.org
  product    = local.product
  region     = local.aws_region
  ecosystem  = local.ecosystem
  account_id = "${get_aws_account_id()}"
}
