variable "name" {
  default = ""
}

variable "project" {
  default = ""
}

variable "subnets" {
  type    = list(any)
  default = []
}