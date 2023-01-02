resource "aws_ecs_cluster" "scraperapidash01" {
  name = "scraperapidash01"
}

resource "aws_ecs_service" "scraper01_service" {
  name            = "scraperapidash01_service"
  cluster         = aws_ecs_cluster.scraperapidash01.id
  task_definition = aws_ecs_task_definition.scraper01_task_definition.arn
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = ["subnet-0f371c07e7a14a4d3"]
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
  task_role_arn            = "arn:aws:iam::094324491160:role/task_role_scrapeapidash"
  execution_role_arn       = "arn:aws:iam::094324491160:role/task_role_scrapeapidash"
  container_definitions    = <<EOF
  [
    {
    "name": "selenium01_container",
    "image": "094324491160.dkr.ecr.us-east-2.amazonaws.com/selenium_repository:latest",
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