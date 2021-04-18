variable "vpc_id" {
  default = "vpc-08281881ee03b9d05"
}

variable "name" {
  default = ""
}

variable "description" {
  default = ""
}

variable "project" {
  default = ""
}

variable "cidr_block" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "ipv6_cidr_block" {
  type    = list(string)
  default = ["::/0"]
}

variable "localip" {
  default = ""
}

variable "desc" {
  default = "HTTP from anywhere"
}

variable "port" {
  default = 8080
}

variable "protocol" {
  default = "tcp"
}