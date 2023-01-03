data "aws_ecr_image" "selenium_image_url" {
  repository_name = var.sel_repository_name
  image_tag       = "latest"
}

data "aws_ecr_image" "api_image_url" {
  repository_name = var.api_repository_name
  image_tag       = "latest"
}

#data "aws_vpc" "vpcid" {
#  filter {
#    name   = "tag:Name"
#    values = ["${var.env}-vpc"]
#  }
#}