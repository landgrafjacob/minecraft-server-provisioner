data "aws_ami" "minecraft" {
  most_recent = true

  filter {
    name   = "name"
    values = ["minecraft-server-ami-*"]
  }

  owners = ["045896359206"]
}

resource "aws_instance" "minecraft" {
  ami           = data.aws_ami.minecraft.id
  instance_type = "t4g.small"
  key_name = "jake-test"
  vpc_security_group_ids = [aws_security_group.minecraft.id]

  tags = {
    Name    = "minecraft-server-${var.server_name}"
    Creator = var.creator_name
  }
}

resource "aws_ec2_instance_state" "minecraft" {
  instance_id = aws_instance.minecraft.id
state = var.instance_state
}

resource "aws_eip" "minecraft" {
  instance = aws_instance.minecraft.id
  domain   = "vpc"
}