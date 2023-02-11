include "root" {
  path = find_in_parent_folders()
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

terraform {
  source = "tfr:///terraform-aws-modules/ec2-instance/aws?version=3.5.0"
}

inputs = {
  name = "bbva"

  ami           = dependency.ami.outputs.ubuntu_linux_image_id
  instance_type = "t3.medium"
  key_name      = "admin-prod"

  disable_api_termination = true

  vpc_security_group_ids = [
    dependency.prod_sg.outputs.security_group_id,
    dependency.bastion_sg.outputs.security_group_id
  ]
  subnet_id = dependency.vpc.outputs.public_subnets[1]

  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      volume_size = 30
    }
  ]

  volume_tags = merge(local.common_vars.common_tags, {
    Snapshot = "true"
  })

  tags = local.common_vars.common_tags
}