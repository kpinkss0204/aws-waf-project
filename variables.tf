variable "region" {
  type        = string
}
variable "project_name" {
  type = string
}
variable "vpc_cidr" {
  type        = string
}
variable "azs" {
  type = list(string)
}
variable "public_key_material" {
  type = string
}
variable "openvpn_ami" {
  type = string
}
variable "db_name" {
  type = string
}
variable "user_name" {
  type = string
}
variable "db_password" {
  type      = string
  sensitive = true
}
variable "db_instance_class" {
  type = string
}
variable "db_engine_version" {
  type = string
}
variable "web_ami" {
  type = string
}
variable "user_data" {
  type = string
}