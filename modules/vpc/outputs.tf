output "vpc_id" {
  value = aws_vpc.netid_vpc.id
}
output "igw_id" {
  value = aws_internet_gateway.netid_igw.id
}