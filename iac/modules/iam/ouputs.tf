output "app_execution_role_arn" {
  description = "sel execution role arn"
  value = aws_iam_role.app_execution_role.arn
}

output "app_task_role_arn" {
  description = "sel task role arn"
  value = aws_iam_role.app_task_role.arn
}