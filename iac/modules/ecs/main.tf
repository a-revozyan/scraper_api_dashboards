resource "aws_ecs_cluster" "scraperapidash01" {
  name = "scraperapidash01"
  tags = {
    Name = "${var.env}-scraperapidash01-cluster"
  }
}

resource "aws_ecs_service" "scraper01_service" {
  name            = var.scraper01_service
  cluster         = aws_ecs_cluster.scraperapidash01.id
  task_definition = aws_ecs_task_definition.scraper01_task_definition.arn
  launch_type     = var.launch_type
  network_configuration {
    subnets          = [var.backend_subnet]
    assign_public_ip = true
  }
  desired_count = 1
  tags = {
    Name = "${var.env}-${var.scraper01_service}"
  }
}

resource "aws_ecs_task_definition" "scraper01_task_definition" {
  family                   = "${var.scraper01_service}_task_definition"
  network_mode             = var.awsvpc_mode
  requires_compatibilities = [var.launch_type]
  memory                   = var.scraper_memory
  cpu                      = var.scraper_cpu
  task_role_arn            = var.ecs_app_task_role
  execution_role_arn       = var.ecs_app_execution_role
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
  name            = var.api01_service
  cluster         = aws_ecs_cluster.scraperapidash01.id
  task_definition = aws_ecs_task_definition.api01_task_definition.arn
  launch_type     = var.launch_type
  load_balancer {
    container_name = "api01_container"
    container_port = var.api01_service_port
    target_group_arn = var.target_group
  }
  network_configuration {
    security_groups  = ["${var.api01_security_group}"]
    subnets          = [var.backend_subnet]
    assign_public_ip = false
  }
  desired_count = 1
  tags = {
    Name = "${var.env}-${var.api01_service}"
  }
}

resource "aws_ecs_task_definition" "api01_task_definition" {
  family                   = "${var.api01_service}_task_definition"
  network_mode             = var.awsvpc_mode
  requires_compatibilities = [var.launch_type]
  memory                   = var.api_memory
  cpu                      = var.api_cpu
  task_role_arn            = var.ecs_app_task_role
  execution_role_arn       = var.ecs_app_execution_role
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
            "awslogs-group": "awslogs-selenium",
            "awslogs-region": "us-east-2",
            "awslogs-stream-prefix": "awslogs-example"
          }
    },
    "portMappings": [
              {
        "hostPort": 5050,
        "protocol": "tcp",
        "containerPort": 5050
          }
      ]
    }
  ]
EOF
}

resource "aws_ecs_service" "dash01_service" {
  name            = var.dash01_service
  cluster         = aws_ecs_cluster.scraperapidash01.id
  task_definition = aws_ecs_task_definition.dash01_task_definition.arn
  launch_type     = var.launch_type
  load_balancer {
    container_name = "dash01_service"
    container_port = var.dash01_service_port
    target_group_arn = var.target_group2
  }
  network_configuration {
    security_groups  = ["${var.dash01_security_group}"]
    subnets          = [var.backend_subnet]
    assign_public_ip = false
  }
  desired_count = 1
  tags = {
    Name = "${var.env}-${var.dash01_service}"
  }
}

resource "aws_ecs_task_definition" "dash01_task_definition" {
  family                   = "${var.dash01_service}_task_definition"
  network_mode             = var.awsvpc_mode
  requires_compatibilities = [var.launch_type]
  memory                   = var.dash_memory
  cpu                      = var.dash_cpu
  task_role_arn            = var.ecs_app_task_role
  execution_role_arn       = var.ecs_app_execution_role
  container_definitions    = <<EOF
  [
    {
    "name": "dash01_service",
    "image": "${data.aws_ecr_image.dash_image_url.registry_id}.dkr.ecr.us-east-2.amazonaws.com/${data.aws_ecr_image.dash_image_url.repository_name}:latest",
    "memory": 2048,
    "cpu": 1024,
    "essential": true,
    "logConfiguration": {
    "logDriver": "awslogs",
        "options": {
            "awslogs-create-group": "true",
            "awslogs-group": "awslogs-dash",
            "awslogs-region": "us-east-2",
            "awslogs-stream-prefix": "awslogs-example"
          }
    },
    "portMappings": [
              {
        "hostPort": 80,
        "protocol": "tcp",
        "containerPort": 80
          }
      ]
    }
  ]
EOF
}