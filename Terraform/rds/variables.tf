variable "name" {
  default = ""
}

variable "project" {
  default = ""
}

variable "db_name" {
  default = ""
}

variable "subnet_group" {
  default = ""
}

variable "dbpassword" {
  sensitive = true
}

variable "dbuser" {
  sensitive = true
}

variable "storage" {
  default = 10
}

variable "security_groups" {
  default = []
}