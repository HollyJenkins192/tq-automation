variable "name" {
  default     = ""
  description = "EC2 Name"
}

variable "ami_id" {
  default     = "ami-08bac620dc84221eb"
  description = "AMI for EC2"
}

variable "subnet" {
  default     = ""
  description = "Subnet for EC2"
}

variable "vpc_security_group_ids" {
  type    = list(any)
  default = []
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "ticket-app-key"

}

variable "project" {
  default = ""
}