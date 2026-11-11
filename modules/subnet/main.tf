resource "aws_subnet" "netid_subnet" {
  for_each          = var.subnets
  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags = {
    Name = "${var.project_name}-${each.key}"
  }
}