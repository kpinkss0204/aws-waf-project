resource "aws_eip" "netid_nat_eip" {
  domain = "vpc"
  tags = {
    Name = "${var.project_name}-nat-eip"
  }
}
resource "aws_nat_gateway" "netid_nat" {
  allocation_id = aws_eip.netid_nat_eip.id
  subnet_id     = var.public_subnet_id
  depends_on    = [aws_eip.netid_nat_eip]
  tags = {
    Name = "${var.project_name}-nat-gw"
  }
}