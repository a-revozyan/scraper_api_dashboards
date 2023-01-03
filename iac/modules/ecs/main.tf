resource "aws_ecs_cluster" "scraperapidash01" {
  name = "scraperapidash01"
}

resource "aws_ecs_service" "scraper01_service" {
  name            = "scraperapidash01_service"
  cluster         = aws_ecs_cluster.scraperapidash01.id
  task_definition = aws_ecs_task_definition.scraper01_task_definition.arn
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = [var.backend_subnet]
    assign_public_ip = true
  }
  desired_count = 1
}

resource "aws_ecs_task_definition" "scraper01_task_definition" {
  family                   = "scraper01_task_definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = "2048"
  cpu                      = "1024"
  task_role_arn            = var.ecs_sel_task_role
  execution_role_arn       = var.ecs_sel_execution_role
  container_definitions    = <<EOF
  [
    {
    "name": "selenium01_container",
    "image": "${data.aws_ecr_image.selenium_image_url.registry_id}.dkr.ecr.us-east-2.amazonaws.com/${data.aws_ecr_image.selenium_image_url.repository_name}:latest",
    "memory": 2048,
    "cpu": 1024,
    "essential": true,
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-create-group": "true",
            "awslogs-group": "awslogs-selenium",
            "awslogs-region": "us-east-2",
            "awslogs-stream-prefix": "awslogs-example"
        }
    },
    "portMappings": []
    }
  ]
EOF
}


resource "aws_ecs_service" "api01_service" {
  name            = "api01_service"
  cluster         = aws_ecs_cluster.scraperapidash01.id
  task_definition = aws_ecs_task_definition.api01_task_definition.arn
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = var.frontend_subnets
    assign_public_ip = true
  }
  desired_count = 1
}

resource "aws_ecs_task_definition" "api01_task_definition" {
  family                   = "api01_task_definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = "2048"
  cpu                      = "1024"
  task_role_arn            = var.ecs_sel_task_role
  execution_role_arn       = var.ecs_sel_execution_role
  container_definitions    = <<EOF
  [
    {
    "name": "api01_container",
    "image": "${data.aws_ecr_image.api_image_url.registry_id}.dkr.ecr.us-east-2.amazonaws.com/${data.aws_ecr_image.api_image_url.repository_name}:latest",
    "memory": 2048,
    "cpu": 1024,
    "essential": true,
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-create-group": "true",
            "awslogs-group": "awslogs-api01",
            "awslogs-region": "us-east-2",
            "awslogs-stream-prefix": "awslogs-example"
        }
    },
    "portMappings": []
    }
  ]
EOF
}