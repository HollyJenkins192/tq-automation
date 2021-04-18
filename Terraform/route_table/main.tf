resource "aws_route_table" "rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.cidr_block
    gateway_id = var.gw_id
  }

  tags = {
    Name    = var.name
    project = var.project
  }
}