output "nginx_dns" {
  value = aws_lb.nginx-alb.dns_name
}
output "wordpress_dns" {
  value = aws_lb.wordpress-alb.dns_name
}
output "tooling_dns" {
  value = aws_lb.tooling-alb.dns_name
}

output "bastion-tg-arn" {
  value = aws_lb_target_group.bastion-tg.arn
}