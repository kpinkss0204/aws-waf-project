output "vpc_id" {
  value = module.vpc.vpc_id
}
output "subnet_ids" {
  value = module.subnet.ids
}
output "openvpn_public_ip" {
  value = module.openvpn.public_ip
}
output "rds_endpoint" {
  value = module.rds.db_endpoint
}
output "alb_dns_name" {
  value = module.alb.dns_name
}