provider "aws" {
  region                  = "eu-west-1"
  shared_credentials_file = "~/.aws/credentials"
}

data "external" "myipaddr" {
  program = ["bash", "-c", "curl -s 'https://api.ipify.org?format=json'"]
}

module "VPC" {
  source     = "./vpc"
  name       = "app-vpc"
  project    = var.project
  cidr_block = var.vpc_cidr_block
}

module "GW" {
  source  = "./internet_gw"
  name    = "igw"
  project = var.project
  vpc_id  = module.VPC.vpc_id
}

module "SubnetPub" {
  source     = "./subnet"
  cidr_block = "${var.cidr_block_start}.0.0/24"
  name       = "pubsub"
  project    = var.project
  vpc_id     = module.VPC.vpc_id
}

module "SubnetPub2" {
  source     = "./subnet"
  cidr_block = "${var.cidr_block_start}.1.0/24"
  name       = "pubsub2"
  project    = var.project
  av_zone    = "eu-west-1b"
  vpc_id     = module.VPC.vpc_id
}

module "SubnetPriv" {
  source     = "./subnet"
  cidr_block = "${var.cidr_block_start}.2.0/24"
  name       = "privsub1"
  project    = var.project
  vpc_id     = module.VPC.vpc_id
  public_ip  = false
  elb        = "internal-elb"
}

module "SubnetPriv2" {
  source     = "./subnet"
  cidr_block = "${var.cidr_block_start}.3.0/24"
  name       = "privsub2"
  project    = var.project
  av_zone    = "eu-west-1b"
  vpc_id     = module.VPC.vpc_id
  public_ip  = false
  elb        = "internal-elb"
}

module "RouteTablePub" {
  source     = "./route_table"
  name       = "public"
  project    = var.project
  cidr_block = "0.0.0.0/0"
  gw_id      = module.GW.gw_id
  vpc_id     = module.VPC.vpc_id

}

module "RouteTablePriv" {
  source     = "./route_table"
  name       = "private"
  project    = var.project
  cidr_block = "${data.external.myipaddr.result.ip}/32"
  gw_id      = module.GW.gw_id
  vpc_id     = module.VPC.vpc_id
}

module "RTAssociations1" {
  source    = "./rtassociation"
  rt_id     = module.RouteTablePub.rt_id
  subnet_id = module.SubnetPub.subnet_id
}

module "RTAssociations2" {
  source    = "./rtassociation"
  rt_id     = module.RouteTablePub.rt_id
  subnet_id = module.SubnetPub2.subnet_id
}


module "RTAssociations3" {
  source    = "./rtassociation"
  rt_id     = module.RouteTablePriv.rt_id
  subnet_id = module.SubnetPriv.subnet_id
}

module "RTAssociations4" {
  source    = "./rtassociation"
  rt_id     = module.RouteTablePriv.rt_id
  subnet_id = module.SubnetPriv2.subnet_id
}

module "RDSSecGroup" {
  source      = "./security_group"
  vpc_id      = module.VPC.vpc_id
  name        = "rds-sg"
  description = "Security group for db instance"
  project     = var.project
  localip     = var.local_host
  cidr_block  = [var.local_host, var.vpc_cidr_block, "0.0.0.0/0"]
  desc        = "MYSQL db access from local machine or local network"
  port        = 3306
}

module "JenkinsSG" {
  source      = "./security_group"
  vpc_id      = module.VPC.vpc_id
  name        = "jenkins-sg"
  description = "Security group for Jenkins server"
  project     = var.project
  localip     = var.local_host
}

module "RDSSubgroup" {
  source  = "./rds_subgrp"
  name    = "rds-subgroup"
  project = var.project
  subnets = [module.SubnetPub.subnet_id, module.SubnetPub2.subnet_id]
}

module "RDS" {
  source       = "./rds"
  project      = var.project
  name      = "ticketsdb"
  subnet_group = module.RDSSubgroup.rds_sub_id
  security_groups = [module.RDSSecGroup.sg_id]
  dbpassword   = var.dbpassword
  dbuser       = var.dbuser
  db_name         = "tickets_db"
}

module "Jenkins" {
  source                 = "./ec2"
  name                   = "jenkins-server"
  subnet                 = module.SubnetPub.subnet_id
  vpc_security_group_ids = [module.JenkinsSG.sg_id]
  instance_type          = "t2.small"
  project                = var.project
}