output "nlb_address" {
  description = "nlb_address"
  value       = aws_lb.nlb.dns_name
}

output "target_group" {
  description = "target_group"
  value       = aws_lb_target_group.nlb_tg.arn
}

output "target_group2" {
  description = "target_group2"
  value       = aws_lb_target_group.nlb_tg2.arn
}