terraform {
  required_version = ">= 0.12.6"

  required_providers {
    aws = ">= 2.28.1"
    helm = "~> 1.2"
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.11"
}

module "eks" {
  source      = "terraform-aws-modules/eks/aws"
  version     = "12.1.0"
  enable_irsa = true

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = var.vpc_id
  subnets         = var.subnets

  node_groups          = var.node_groups
  node_groups_defaults = var.node_groups_defaults

  map_roles    = var.map_roles
  map_users    = var.map_users  

  tags = {
    Terraform  = "true"
  }
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
    load_config_file       = false
  }
}

resource "null_resource" "wait_for_eks" {
  provisioner "local-exec" {
    command = "echo Cluster ID is ${module.eks.cluster_id}"
  }
}