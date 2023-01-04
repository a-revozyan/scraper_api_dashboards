output "aws_ecr_repository_URL" {
  description = "arn of ecr repository - api"
  value = data.aws_ecr_image.selenium_image_url
}

output "api01_service_id" {
  description = "api01_service ARN"
  value = aws_ecs_service.api01_service.id
}

output "api01_service_id_test" {
  description = "api01_service ARN"
  value = aws_ecs_service.api01_service.name
}
