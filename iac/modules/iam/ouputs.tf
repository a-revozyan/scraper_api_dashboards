output "sel_execution_role_arn" {
  description = "sel execution role arn"
  value = aws_iam_role.sel_execution_role.arn
}

output "sel_task_role_arn" {
  description = "sel task role arn"
  value = aws_iam_role.sel_task_role.arn
}