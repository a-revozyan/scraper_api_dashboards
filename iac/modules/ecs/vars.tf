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

variable "awsvpc_mode" {
  description = "awsvpc_mode"
  default     = "awsvpc"
}

variable "scraper01_service" {
  description = "for names, etc"
  default     = "scraper01_service"
}

variable "scraper_memory" {
  description = "scraper_memory"
  default     = "2048"
}

variable "scraper_cpu" {
  description = "scraper_cpu"
  default     = "1024"
}

variable "api01_service" {
  description = "for names, etc"
  default     = "api01_service"
}

variable "api01_service_port" {
  description = "api01_service_port"
  default     = "5050"
}

variable "api_memory" {
  description = "scraper_memory"
  default     = "2048"
}

variable "api_cpu" {
  description = "scraper_cpu"
  default     = "1024"
}

variable "dash01_service" {
  description = "for names, etc"
  default     = "dash01_service"
}

variable "dash01_service_port" {
  description = "for names, etc"
  default     = "80"
}

variable "dash_memory" {
  description = "scraper_memory"
  default     = "2048"
}

variable "dash_cpu" {
  description = "scraper_cpu"
  default     = "1024"
}

variable "launch_type" {
  description = "scraper_cpu"
  default     = "FARGATE"
}