resource "aws_instance" "terraformVm" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet
  vpc_security_group_ids = var.vpc_security_group_ids
  tags = {
    Name    = var.name
    project = var.project
  }
  associate_public_ip_address = "true"
}