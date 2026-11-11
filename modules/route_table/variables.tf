variable "project_name" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "internet_gateway_id" {
  type = string
}
variable "nat_gateway_id" {
  type = string
}
variable "public_subnet_ids" {
  type = list(string)
}
variable "web_subnet_ids" {
  type = list(string)
}
variable "db_subnet_ids" {
  type = list(string)
}