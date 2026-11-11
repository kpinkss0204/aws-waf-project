resource "aws_launch_template" "netid_launch_template" {
  name                   = "${var.project_name}-lt"
  description            = "version 1.0"
  image_id               = var.ami
  instance_type          = "t3.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_id]
  user_data              = base64encode(var.user_data)
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project_name}-web"
    }
  }
}