resource "aws_key_pair" "netid_key_pair" {
  key_name   = "${var.project_name}-key"
  public_key = var.public_key_material
}
