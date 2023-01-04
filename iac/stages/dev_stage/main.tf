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
  env    = "devstage"
}

module "vpc" {
  source = "../../modules/vpc/"
  env    = "devstage"
}

module "iam" {
  depends_on              = [module.s3, module.vpc]
  source                  = "../../modules/iam/"
  cars_data_s3_bucket_arn = module.s3.cars_data_s3_bucket_arn
  env                     = "devstage"
}

module "ecr" {
  depends_on = [module.iam]
  source = "../../modules/ecr/"
  env    = "devstage"
}

module "sgs" {
  source = "../../modules/sgs"
  vpc_id = module.vpc.vpc_id
  env    = var.stage
}

module "ecs" {
  depends_on              = [module.iam, module.ecr]
  source                  = "../../modules/ecs/"
  ecs_app_task_role       = module.iam.app_task_role_arn
  ecs_app_execution_role  = module.iam.app_execution_role_arn
  sel_repository_arn      = module.ecr.aws_ecr_repository_arn_selenium
  sel_repository_name     = module.ecr.aws_ecr_repository_name_selenium
  api_repository_arn      = module.ecr.aws_ecr_repository_arn_api
  api_repository_name     = module.ecr.aws_ecr_repository_name_api
  dash_repository_arn     = module.ecr.aws_ecr_repository_arn_dash
  dash_repository_name    = module.ecr.aws_ecr_repository_name_dash
  backend_subnet          = module.vpc.backend-subnet_ids
  frontend_subnets        = module.vpc.frontend-subnet_ids
  api01_security_group    = module.sgs.api_sg_5050
  dash01_security_group   = module.sgs.dash_sg_5000
  target_group            = module.nlb.target_group
  target_group2           = module.nlb.target_group2
  env                     = var.stage
}

module "nlb" {
  depends_on            = [module.vpc]
  source                = "../../modules/nlb/"
  vpc_id                = module.vpc.vpc_id
  frontend_subnet_ids   = module.vpc.frontend-subnet_ids
#  ecs_api01_service_id  = module.ecs.api01_service_id
  env                   = var.stage
}