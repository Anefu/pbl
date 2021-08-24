output "vpc_id" {
  value = aws_vpc.main.id
}
output "public-subnets" {
  value = aws_subnet.public[*].id
}
output "private-subnets" {
  value = aws_subnet.private[*].id
}
output "alb-sg" {
  value = aws_security_group.alb-sg.id
}

output "bastion_sg" {
  value = aws_security_group.bastion_sg.id
}

output "efs_subnets" {
  value = [aws_subnet.private[2].id,aws_subnet.private[3].id]
}

output "efs_sg" {
  value = "${aws_security_group.EFS-SG.id}"
}
# output "alb_target_group_arn" {
#   value = aws_lb_target_group.my-target-group.arn
# }

#output "s3_bucket_arn" {
#  value       = aws_s3_bucket.terraform_state.arn
#  description = "The ARN of the S3 bucket"
#}
#output "dynamodb_table_name" {
#  value       = aws_dynamodb_table.terraform_locks.name
#  description = "The name of the DynamoDB table"
#}