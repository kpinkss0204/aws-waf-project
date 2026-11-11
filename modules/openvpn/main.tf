resource "aws_instance" "netid_openvpn" {
  ami                         = var.ami
  instance_type               = "t3.micro"
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  private_ip                  = var.private_ip
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.security_group_id]
  tags = {
    Name = "${var.project_name}-openvpn"
  }
}
resource "aws_eip" "netid_vpn_eip" {
  domain = "vpc"
  tags = {
    Name = "${var.project_name}-eip-openvpn"
  }
}
resource "aws_eip_association" "netid_eip_ass" {
  allocation_id = aws_eip.netid_vpn_eip.id
  instance_id   = aws_instance.netid_openvpn.id
}