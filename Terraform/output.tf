output "JenkinsIp" {
  value = module.Jenkins.public_ip
}

output "VPCId" {
  value = module.VPC.vpc_id
}

output "VPCblock" {
  value = var.vpc_cidr_block
}

output "PubSubId" {
  value = module.SubnetPub.subnet_id
}

output "PubSub2Id" {
  value = module.SubnetPub2.subnet_id
}

output "PrivSubId" {
  value = module.SubnetPriv.subnet_id
}

output "PrivSub2Id" {
  value = module.SubnetPriv2.subnet_id
}

output "RDSEndpoint" {
  value = module.RDS.rds_endpoint
}