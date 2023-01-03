variable "ecs_sel_task_role" {
  description = "ecs_sel_task_role"
  type        = string
}

variable "ecs_sel_execution_role" {
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