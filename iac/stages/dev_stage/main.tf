terraform {
  required_version = "1.3.6"

  backend "s3" {
    bucket         = "maintfstatebucketarevozyan"
    dynamodb_table = "main_terraformtfstate"
    key            = "dev_stage/scraperapidash/terraform.tfstate"
    region         = "us-east-2"
  }
}

module "s3" {
  source = "../../modules/s3/"
}

module "vpc" {
  source = "../../modules/vpc"
  env    = "dev_stage"
}

module "iam" {
  depends_on              = [module.s3, module.vpc]
  source                  = "../../modules/iam/"
  cars_data_s3_bucket_arn = module.s3.cars_data_s3_bucket_arn
}

module "ecr" {
  depends_on = [module.iam]
  source = "../../modules/ecr/"
}

module "ecs" {
  depends_on              = [module.iam, module.ecr]
  source                  = "../../modules/ecs"
  ecs_sel_task_role       = module.iam.sel_task_role_arn
  ecs_sel_execution_role  = module.iam.sel_execution_role_arn
  sel_repository_arn      = module.ecr.aws_ecr_repository_arn_selenium
  sel_repository_name     = module.ecr.aws_ecr_repository_name_selenium
  api_repository_arn      = module.ecr.aws_ecr_repository_arn_api
  api_repository_name     = module.ecr.aws_ecr_repository_name_api
  dash_repository_arn     = module.ecr.aws_ecr_repository_arn_dash
  dash_repository_name    = module.ecr.aws_ecr_repository_name_dash
  backend_subnet          = module.vpc.backend-subnet_ids
  frontend_subnets        = module.vpc.frontend-subnet_ids
}