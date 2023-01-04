variable "env" {
  description = "environment"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "frontend_subnet_ids" {
  description = "frontend subnet ids"
  type        = list(string)
}

variable "ecs_api01_service_id" {
  description = "frontend subnet ids"
  type        = string
}