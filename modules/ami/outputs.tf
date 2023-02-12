output "amazon_linux_image_id" {
  value = data.aws_ami.amazon_linux.id

}

output "ubuntu_linux_image_id" {
  value = data.aws_ami.ubuntu.id
}
