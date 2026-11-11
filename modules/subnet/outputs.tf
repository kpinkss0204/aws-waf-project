output "ids" {
  value = { for k, s in aws_subnet.netid_subnet : k => s.id }
}