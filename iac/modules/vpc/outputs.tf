#output "backend-subnet_ids" {
#  description = "backend subnets' ids"
#  value       = coalescelist(aws_subnet.backend_subnet.*.id)
#}
output "backend-subnet_ids" {
  description = "backend subnets' ids"
#  value       = coalescelist(aws_subnet.backend_subnet.*.id)
  value       = aws_subnet.backend_subnet.0.id
}

output "frontend-subnet_ids" {
  description = "frontend subnets' ids"
  value       = coalescelist(aws_subnet.frontend_subnet.*.id)
}