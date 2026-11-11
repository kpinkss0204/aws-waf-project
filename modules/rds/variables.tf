variable "project_name" {
  type = string
}
variable "db_subnet_ids" {
  type = list(string)
}
variable "security_group_id" {
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
variable "instance_class" {
  type = string
}
variable "engine_version" {
  type = string
}