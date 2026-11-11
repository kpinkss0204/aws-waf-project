resource "aws_route_table" "netid_public" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.project_name}-pub-rt12"
  }
}
resource "aws_route" "netid_public_default" {
  route_table_id         = aws_route_table.netid_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}
resource "aws_route_table_association" "netid_public_ass" {
  for_each = {
    for idx, id in var.public_subnet_ids : idx => id
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.netid_public.id
}
resource "aws_route_table" "netid_web" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.project_name}-web-rt34"
  }
}
resource "aws_route" "netid_web_default" {
  route_table_id         = aws_route_table.netid_web.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_gateway_id
}
resource "aws_route_table_association" "netid_web_ass" {
  for_each = {
    for idx, id in var.web_subnet_ids : idx => id
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.netid_web.id
}
resource "aws_route_table" "netid_db" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.project_name}-db-rt56"
  }
}
resource "aws_route_table_association" "netid_db_ass" {
  for_each = {
    for idx, id in var.db_subnet_ids : idx => id
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.netid_db.id
}
