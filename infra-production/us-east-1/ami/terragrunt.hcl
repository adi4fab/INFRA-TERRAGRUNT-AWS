include "root" {
  path = find_in_parent_folders()
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

terraform {
  source = "../../../modules/ami"
}

inputs = {
  amazon_linux_image_name = local.common_vars.amazon_linux_image_name
  ubuntu_linux_image_name = local.common_vars.ubuntu_linux_image_name

}