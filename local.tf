locals {
  subnets = {
    "pub-sn1" = { cidr = cidrsubnet(var.vpc_cidr, 8, 1), az = var.azs[0] }
    "pub-sn2" = { cidr = cidrsubnet(var.vpc_cidr, 8, 2), az = var.azs[1] }
    "web-sn3" = { cidr = cidrsubnet(var.vpc_cidr, 8, 3), az = var.azs[0] }
    "web-sn4" = { cidr = cidrsubnet(var.vpc_cidr, 8, 4), az = var.azs[1] }
    "db-sn5" = { cidr = cidrsubnet(var.vpc_cidr, 8, 5), az = var.azs[0] }
    "db-sn6" = { cidr = cidrsubnet(var.vpc_cidr, 8, 6), az = var.azs[1] }
  }
}