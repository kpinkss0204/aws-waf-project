variable "name" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "ingress" {
  type = list(object({ protocol = string, from = number, to = number, cidr = string }))
}