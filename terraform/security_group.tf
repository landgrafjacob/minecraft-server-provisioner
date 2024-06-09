data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "minecraft" {
  name        = "allow_tls"
  description = "Allow SSH/25565 ingress and all egress"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.minecraft.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_minecraft" {
  security_group_id = aws_security_group.minecraft.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 25565
  ip_protocol = "tcp"
  to_port     = 25565
}

resource "aws_vpc_security_group_egress_rule" "allow_egress_ipv4" {
  security_group_id = aws_security_group.minecraft.id

  ip_protocol  = "-1"
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow_egress_ipv6" {
  security_group_id = aws_security_group.minecraft.id

  ip_protocol  = "-1"
  cidr_ipv6 = "::/0"
}