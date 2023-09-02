terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.15.0"
    }
  }
}

locals {
  tags = {
    Name        = "thalia-${var.stage}-${var.project_name}"
    Category    = var.project_name,
    Owner       = "technicie",
    Environment = var.stage,
    Terraform   = true
  }
}

module "network" {
  source = "./modules/network"
  tags   = local.tags
}

module "dns" {
  source      = "./modules/dns"
  zone_name   = var.zone_name
  webdomain   = var.domain
  public_ipv4 = module.network.public_ipv4
  public_ipv6 = module.network.public_ipv6
}

module "server" {
  source               = "./modules/server"
  tags                 = local.tags
  aws_interface_id     = module.network.aws_interface_id
  ssh_public_key       = var.ssh_public_key
  ec2_instance_type    = var.ec2_instance_type
  ec2_ami              = var.ec2_ami
  ec2_root_volume_size = var.ec2_root_volume_size
  volumes              = var.volumes
}

module "buckets" {
  source      = "./modules/s3"
  for_each    = var.s3_buckets
  tags        = local.tags
  name_suffix = each.key
  versioning  = each.value.versioning
  ec2_role_id = module.server.ec2_role_id
}

