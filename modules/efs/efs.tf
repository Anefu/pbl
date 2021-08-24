resource "aws_efs_file_system" "efs" {
  tags =  var.efs_tags
  encrypted = true
  kms_key_id = aws_kms_key.kms.arn
}

resource "aws_efs_mount_target" "mounta" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.efs_subnet_id[0]
  security_groups = var.efs_sg
}

resource "aws_efs_mount_target" "mountb" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.efs_subnet_id[1]
  security_groups = var.efs_sg
}