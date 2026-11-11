resource "aws_vpc" "netid_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.project_name}-vpc"
  }
}
resource "aws_internet_gateway" "netid_igw" {
  vpc_id = aws_vpc.netid_vpc.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}