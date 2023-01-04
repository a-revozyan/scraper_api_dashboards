### SELENIUM TASK AND EXCUTION ROLES ###
resource "aws_iam_policy" "app_execution_policy" {
  name = "app_execution_policy"
  path = "/"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        },
        {
              "Effect": "Allow",
              "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogStreams"
            ],
              "Resource": [
                "arn:aws:logs:*:*:*"
            ]
        },
        {
              "Effect": "Allow",
              "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogStreams"
            ],
              "Resource": [
                "arn:aws:logs:*:*:*"
            ]
        }
    ]
}
EOF
  tags = {
    Name = "${var.env}-app_execution_policy"
  }
}

resource "aws_iam_role" "app_execution_role" {
  name = "app_execution_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
  tags = {
    Name = "${var.env}-app_execution_role"
  }
}

resource "aws_iam_role_policy_attachment" "app_execution_role_attachment" {
  role       = aws_iam_role.app_execution_role.name
  policy_arn = aws_iam_policy.app_execution_policy.arn
}

resource "aws_iam_policy" "app_task_policy" {
  name = "sel_task_policy"
  path = "/"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:PutObjectAcl",
                "s3:GetObject",
                "s3:GetObjectAcl"
            ],
            "Resource": [
                "${var.cars_data_s3_bucket_arn}",
                "${var.cars_data_s3_bucket_arn}/*"
            ]
        }
    ]
}
EOF
  tags = {
    Name = "${var.env}-app_execution_role_attachment"
  }
}

resource "aws_iam_role" "app_task_role" {
  name = "sel_task_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
  tags = {
    Name = "${var.env}-app_task_role"
  }
}

resource "aws_iam_role_policy_attachment" "app_task_role_attachment" {
  role       = aws_iam_role.app_task_role.name
  policy_arn = aws_iam_policy.app_task_policy.arn
}
