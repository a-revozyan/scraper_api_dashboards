output "aws_ecr_repository_URL" {
  description = "arn of ecr repository - api"
  value = data.aws_ecr_image.selenium_image_url
}

