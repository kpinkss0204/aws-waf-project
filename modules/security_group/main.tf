resource "aws_security_group" "netid_security_group" {
  name        = var.name
  description = var.name
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = var.ingress
    content {
      protocol    = ingress.value.protocol
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      cidr_blocks = [ingress.value.cidr]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.name
  }
}
