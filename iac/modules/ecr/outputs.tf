output "aws_ecr_repository_arn_selenium" {
  description = "arn of ecr repository - selenium"
  value = aws_ecr_repository.selenium.arn
}

output "aws_ecr_repository_name_selenium" {
  description = "name of ecr repository - selenium"
  value = aws_ecr_repository.selenium.name
}

output "aws_ecr_repository_arn_api" {
  description = "arn of ecr repository - api"
  value = aws_ecr_repository.api.arn
}

output "aws_ecr_repository_name_api" {
  description = "name of ecr repository - api"
  value = aws_ecr_repository.api.name
}

output "aws_ecr_repository_arn_dash" {
  description = "arn of ecr repository - dash"
  value = aws_ecr_repository.dash.arn
}

output "aws_ecr_repository_name_dash" {
  description = "name of ecr repository - dash"
  value = aws_ecr_repository.dash.name
}
