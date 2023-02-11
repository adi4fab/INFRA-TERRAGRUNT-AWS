include "root" {
  path = find_in_parent_folders()
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

terraform {
  source = "tfr:///terraform-aws-modules/vpc/aws?version=3.14.0"
}

inputs = {
  name = "production-main"
  cidr = "10.10.0.0/16"

  azs = ["us-east-1a", "us-east-1b", "us-east-1c"]

  public_subnets = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24"]

  private_subnets = ["10.10.16.0/20", "10.10.32.0/20", "10.10.48.0/20"]

  enable_nat_gateway = true


  tags = local.common_vars.common_tags
}
