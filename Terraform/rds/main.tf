resource "aws_db_instance" "rds" {
  engine               = "mysql"
  engine_version       = "8.0.23"
  instance_class       = "db.t2.micro"
  name                 = var.db_name
  identifier           = var.name
  username             = var.dbuser
  password             = var.dbpassword
  parameter_group_name = "default.mysql8.0"
  db_subnet_group_name = var.subnet_group
  allocated_storage    = var.storage
  skip_final_snapshot  = true
  vpc_security_group_ids = var.security_groups
  publicly_accessible  = true
  tags = {
    Name    = var.name
    project = var.project
  }
}