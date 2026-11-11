output "target_group_arn" {
  value = aws_lb_target_group.netid_target_group.arn
}
output "dns_name" {
  value = aws_lb.netid_alb.dns_name
}