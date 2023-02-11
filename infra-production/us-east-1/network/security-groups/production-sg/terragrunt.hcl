include "root" {
  path = find_in_parent_folders()
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

dependency "vpc" {
  config_path = "../../vpc"
}

terraform {
  source = "tfr:///terraform-aws-modules/security-group/aws?version=4.9.0"
}

inputs = {
  name        = "production-sg"
  description = "Production SG"
  vpc_id      = dependency.vpc.outputs.vpc_id

  ingress_with_self = [
    {
      rule = "all-all"
    },
  ]

  egress_with_self = [
    {
      rule = "all-all"
    },
  ]

  egress_rules = [
    "http-80-tcp",
    "https-443-tcp",
    "ssh-tcp"
  ]

  egress_with_cidr_blocks = [

    {
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      description = "icmp legacy traffic port"
      cidr_blocks = "0.0.0.0/0"
    },


  ]

  tags = local.common_vars.common_tags
}
