resource "aws_instance" "Bastion" {
  ami                         = var.bastion_ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_groups
  key_name                    = aws_key_pair.praise.key_name

  tags = {
    Name = "Bastion"
  }
}