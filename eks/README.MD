# EKS Module
[Modulo EKS - Oficial](https://github.com/terraform-aws-modules/terraform-aws-eks)

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.28.1 |
| kubernetes | >= 1.11.1 |
| local | >= 1.4 |
| null | >= 2.1 |
| random | >= 2.1 |
| template | >= 2.1 |
| helm | ~> 1.2 |

## Inputs

| Nome | Descrição | Tipo | Default | Obrigatorio |
|------|-------------|------|---------|:--------:|
| aws_region | Regiao AWS | string | "" | sim |
| cluster_name | Nome do Cluster | string | "" | sim |
| cluster_version | Versao do Cluster | string | "1.16" | sim |
| subnets | ID das subnets publicas e privadas | list(string) | "" | sim |
| vpc_id | ID da VPC | string | "" | sim |
| map_roles | ARN+NomeDoUsuario+TipoDeAcesso de roles da AWS que terao acesso ao cluster | list(object({rolearn=string,username=string, groups=list(string)})) | [] | sim |
| map_users | ARN+NomeDoUsuario+TipoDeAcesso de usuarios da AWS que terao acesso ao cluster | list(object({userarn=string,username=string, groups=list(string)})) | [] | sim |
| node_groups_defaults | Valores aplicado a todos node_groups | any | "" | sim |
| node_groups | Lista de node groups do cluster | list | [] | sim |
| nginx_ingress_dns | Ingress DNS, example nginx.aws.internal | string | "" | sim |
| ingress_cert_arn | Certificate ARN for ELB SSL Termination | string | "" | sim |