resource "aws_db_subnet_group" "netid_subnet_group" {
  name       = "${var.project_name}-db-sng"
  subnet_ids = var.db_subnet_ids
  tags       = { Name = "${var.project_name}-db-sng" }
}
resource "aws_db_instance" "netid_db" {
  identifier              = "my-mysql-rds"
  engine                  = "mysql"
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = 20
  storage_type            = "gp3"
  db_name                 = var.db_name
  username                = var.user_name
  password                = var.db_password
  vpc_security_group_ids  = [var.security_group_id]
  db_subnet_group_name    = aws_db_subnet_group.netid_subnet_group.name
  multi_az                = false
  publicly_accessible     = false
  backup_retention_period = 1
  storage_encrypted       = true
  deletion_protection     = false
  skip_final_snapshot     = true
  tags = {
    Name = "${var.project_name}-rds"
  }
}
