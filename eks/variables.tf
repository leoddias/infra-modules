variable "aws_region" {
  description = "AWS Region."
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster."
  type        = string
  default     = "1.16"
}

variable "subnets" {
  description = "A list of subnets to place the EKS cluster and workers within."
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC where the cluster and workers will be deployed."
  type        = string
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn:aws:iam::66666666666:user/user1"
      username = "user1"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::66666666666:user/user2"
      username = "user2"
      groups   = ["system:masters"]
    },
  ]
}

variable "node_groups" {
  description = "Map of map of node groups to create. See `node_groups` module's documentation for more details"
  type        = any
  default     = {
    principal = {
      name             = "principal"
      desired_capacity = 1
      max_capacity     = 10
      min_capacity     = 1
  
      instance_type = "m5.large"
      k8s_labels = {
        nodeGroup = "principal"
      }
    }
  }
}

variable "node_groups_defaults" {
  description = "Map of values to be applied to all node groups. See `node_groups` module's documentaton for more details"
  type        = any
  default     = {
    ami_type  = "AL2_x86_64"
    disk_size = 50
  }
}

variable "nginx_ingress_dns" {
  description = "Ingress DNS, example nginx.aws.internal"
  type        = string
}

variable "ingress_cert_arn" {
  description = "Certificate ARN for ELB SSL Termination"
  type        = string
}