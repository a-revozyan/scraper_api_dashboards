variable "ecs_app_task_role" {
  description = "ecs_sel_task_role"
  type        = string
}

variable "ecs_app_execution_role" {
  description = "ecs_sel_execution_role"
  type        = string
}

variable "sel_repository_arn" {
  description = "sel_repository_arn"
  type        = string
}

variable "api_repository_arn" {
  description = "api_repository_arn"
  type        = string
}

variable "dash_repository_arn" {
  description = "dash_repository_arn"
  type        = string
}

variable "sel_repository_name" {
  description = "sel_repository_name"
  type        = string
}

variable "api_repository_name" {
  description = "api_repository_name"
  type        = string
}

variable "dash_repository_name" {
  description = "dash_repository_name"
  type        = string
}

variable "backend_subnet" {
  description = "backend_subnet for scraper"
  type        = string
}

variable "frontend_subnets" {
  description = "frontend_subnets for api and dash"
  type        = list(string)
}

variable "env" {
  description = "environment"
  type        = string
}

variable "api01_security_group" {
  description = "security group id for API01"
  type        = string
}

variable "dash01_security_group" {
  description = "security group id for DASH01"
  type        = string
}

variable "target_group" {
  description = "target_group"
  type        = string
}

variable "target_group2" {
  description = "target_group2"
  type        = string
}