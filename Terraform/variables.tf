variable "project" {
  default = "ticket-app-test"
}

variable "vpc_cidr_block" {
  default = "10.2.0.0/16"
}

variable "cidr_block_start" {
  default = "10.2"
}

variable "local_host" {
  default = "5.64.98.246/32"
}

variable "dbpassword" {
  sensitive = true
}

variable "dbuser" {
  sensitive = true
}