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
