output "api_sg_5050" {
  description = "SG for API01 service"
  value = aws_security_group.sg_api01_service.id
}

output "dash_sg_5000" {
  description = "SG for DASH01 service"
  value = aws_security_group.sg_dash01_service.id
}
