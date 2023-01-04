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

variable "api_port_target_group" {
  description = "api_port_target_group"
  default     = "5050"
}

variable "dash_port_target_group" {
  description = "dash_port_target_group"
  default     = "80"
}

variable "tcp" {
  description = "layer 4"
  default     = "TCP"
}

variable "target_type" {
  description = "target_type"
  default     = "ip"
}