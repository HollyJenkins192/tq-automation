resource "aws_subnet" "subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block
  availability_zone       = var.av_zone
  map_public_ip_on_launch = var.public_ip
  tags = {
    Name                                          = var.name
    project                                       = var.project
    "alpha.eksctl.io/cluster-name"                = var.project
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = var.project
    "kubernetes.io/cluster/${var.project}"        = "shared"
    "kubernetes.io/role/${var.elb}"               = 1
  }
}