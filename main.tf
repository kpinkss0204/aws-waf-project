module "vpc" {
  source = "./modules/vpc"
  project_name = var.project_name
  vpc_cidr = var.vpc_cidr
}
module "subnet" {
  source = "./modules/subnet"
  project_name = var.project_name
  vpc_id = module.vpc.vpc_id
  subnets = local.subnets
}
module "nat" {
  source = "./modules/nat"
  project_name = var.project_name
  public_subnet_id = module.subnet.ids["pub-sn1"]
}
module "route_table" {
  source = "./modules/route_table"
  project_name = var.project_name
  vpc_id = module.vpc.vpc_id
  internet_gateway_id = module.vpc.igw_id
  nat_gateway_id = module.nat.id
  public_subnet_ids = [module.subnet.ids["pub-sn1"], module.subnet.ids["pub-sn2"]]
  web_subnet_ids = [module.subnet.ids["web-sn3"], module.subnet.ids["web-sn4"]]
  db_subnet_ids = [module.subnet.ids["db-sn5"], module.subnet.ids["db-sn6"]]
}
module "key_pair" {
  source = "./modules/key_pair"
  project_name = var.project_name
  public_key_material = var.public_key_material
}
module "openvpn_sg" {
  source = "./modules/security_group"
  name = "${var.project_name}-openvpn-sg"
  vpc_id = module.vpc.vpc_id
  ingress = [
    { protocol = "tcp", from = 22, to = 22, cidr = "0.0.0.0/0"},
    { protocol = "tcp", from = 443, to = 443, cidr = "0.0.0.0/0"},
    { protocol = "tcp", from = 80, to = 80, cidr = "0.0.0.0/0"},
    { protocol = "tcp", from = 943, to = 943, cidr = "0.0.0.0/0"},
    { protocol = "tcp", from = 945, to = 945, cidr = "0.0.0.0/0"},
    { protocol = "udp", from = 1194, to = 1194, cidr = "0.0.0.0/0"}
  ]
}
module "openvpn" {
  source = "./modules/openvpn"
  project_name = var.project_name
  ami = var.openvpn_ami
  subnet_id = module.subnet.ids["pub-sn2"]
  security_group_id = module.openvpn_sg.id
  key_name = module.key_pair.name
  private_ip = cidrhost(cidrsubnet(var.vpc_cidr, 8, 2), 100)
}
module "db_sg" {
  source = "./modules/security_group"
  name   = "${var.project_name}-db-sg"
  vpc_id = module.vpc.vpc_id
  ingress = [
    { protocol = "tcp", from = 3306, to = 3306, cidr = var.vpc_cidr }
  ]
}
module "rds" {
  source            = "./modules/rds"
  project_name      = var.project_name
  db_subnet_ids     = [module.subnet.ids["db-sn5"], module.subnet.ids["db-sn6"]]
  security_group_id = module.db_sg.id
  db_name           = var.db_name
  user_name         = var.user_name
  db_password       = var.db_password
  instance_class    = var.db_instance_class
  engine_version    = var.db_engine_version
}
module "alb_sg" {
  source = "./modules/security_group"
  name   = "${var.project_name}-web-alb-sg"
  vpc_id = module.vpc.vpc_id
  ingress = [
    { protocol = "tcp", from = 80, to = 80, cidr = "0.0.0.0/0" },
    { protocol = "tcp", from = 443, to = 443, cidr = "0.0.0.0/0" }
  ]
}
module "web_sg" {
  source = "./modules/security_group"
  name   = "${var.project_name}-web-sg"
  vpc_id = module.vpc.vpc_id
  ingress = [
    { protocol = "tcp", from = 22, to = 22, cidr = var.vpc_cidr },
    { protocol = "tcp", from = 80, to = 80, cidr = "0.0.0.0/0" },
    { protocol = "tcp", from = 443, to = 443, cidr = "0.0.0.0/0" }
  ]
}
module "alb" {
  source            = "./modules/alb"
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = [module.subnet.ids["pub-sn1"], module.subnet.ids["pub-sn2"]]
  security_group_id = module.alb_sg.id
}
module "launch_template" {
  source            = "./modules/launch_template"
  project_name      = var.project_name
  ami               = var.web_ami
  key_name          = module.key_pair.name
  security_group_id = module.web_sg.id
  user_data         = var.user_data
}
module "autoscaling" {
  source                  = "./modules/autoscaling"
  project_name            = var.project_name
  subnet_ids              = [module.subnet.ids["web-sn3"], module.subnet.ids["web-sn4"]]
  target_group_arn        = module.alb.target_group_arn
  launch_template_id      = module.launch_template.id
  launch_template_version = module.launch_template.latest_version
  depends_on              = [module.route_table]
}