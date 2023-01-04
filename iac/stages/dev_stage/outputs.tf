output "api01_service_id" {
  description = "api01_service_id"
  value = module.ecs.api01_service_id
}

output "nlb_dns_name" {
  description = "nlb_dns_name"
  value = module.nlb.nlb_address
}