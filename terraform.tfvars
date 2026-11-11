region              = "ap-northeast-2"
project_name        = "netid"
vpc_cidr            = "172.16.0.0/16"
azs                 = ["ap-northeast-2a", "ap-northeast-2c"]
public_key_material = "ssh-rsa 2048 SHA256:t+T0qPiPLHssPSt3/KU3NED28CS2aB0nXxbZoq4Ak9s"
web_ami             = "ami-0131b10cfa2943e15"
openvpn_ami         = "ami-0f42c79eb0c2339c9"
db_name             = "webDB"
user_name           = "root"
db_instance_class   = "db.t3.micro"
db_engine_version   = "8.4.11"
user_data           = <<-EOT
  #!/bin/bash
  yum install -y httpd php php-mbstring php-pdo php-mysqlnd php-gd wget unzip
  wget -O /tmp/frontend_source.zip https://github.com/netidgo/aws-waf-project/raw/refs/heads/main/frontend_source.zip
  unzip -o /tmp/frontend_source.zip -d /var/www/html/
  systemctl start httpd & systemctl enable httpd
  EOT
