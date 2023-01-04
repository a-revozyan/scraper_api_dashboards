variable "env" {
  description = "environment"
  type        = string
}

variable "vpc_id" {
  description = "vpc_id - custom"
  type        = string
}

variable "api_port_sec_group" {
  description = "api_port_sec_group"
  default     = "5050"
}

variable "dash_port_sec_group" {
  description = "dash_port_sec_group"
  default     = "80"
}

variable "egress_port" {
  description = "egress_port"
  default     = "0"
}

variable "tcp" {
  description = "4 layer"
  default     = "tcp"
}

variable "cidr_block" {
  description = "cidr_block for sec groups"
  default     = "0.0.0.0/0"
}

variable "protocol_egress" {
  description = "egress '-1'"
  default     = "-1"
}