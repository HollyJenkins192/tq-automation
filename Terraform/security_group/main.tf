resource "aws_security_group" "sg" {
  vpc_id      = var.vpc_id
  name        = var.name
  description = var.description

  ingress {
    description      = var.desc
    from_port        = var.port
    to_port          = var.port
    protocol         = var.protocol
    cidr_blocks      = var.cidr_block
    ipv6_cidr_blocks = var.ipv6_cidr_block
  }

  ingress {
    description = "SSH from admin pc"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.localip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = var.name
    project = var.project
  }
}