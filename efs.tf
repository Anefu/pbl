resource "aws_efs_file_system" "efs" {
  tags =  {
    Name = "efs"
  }
  encrypted = true
  kms_key_id = aws_kms_key.kms.arn
}

resource "aws_efs_mount_target" "mounta" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_subnet.private[0].id
  security_groups = [aws_security_group.EFS-SG.id]
}

resource "aws_efs_mount_target" "mountb" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_subnet.private[1].id
  security_groups = [aws_security_group.EFS-SG.id]
}