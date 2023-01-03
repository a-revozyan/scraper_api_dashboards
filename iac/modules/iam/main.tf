#resource "aws_iam_policy" "task_execution_policy" {
#  name = "task_execution_policy"
#  path = "/"
#  policy = <<EOF
#{
#    "Version": "2012-10-17",
#    "Statement": [
#        {
#            "Effect": "Allow",
#            "Action": [
#                "ecr:GetAuthorizationToken",
#                "ecr:BatchCheckLayerAvailability",
#                "ecr:GetDownloadUrlForLayer",
#                "ecr:BatchGetImage",
#                "logs:CreateLogStream",
#                "logs:PutLogEvents"
#            ],
#            "Resource": "*"
#        },
#        {
#            "Effect": "Allow",
#            "Action": [
#                "s3:PutObject",
#                "s3:PutObjectAcl",
#                "s3:GetObject",
#                "s3:GetObjectAcl"
#            ],
#            "Resource": [
#                "arn:aws:s3:::datacollectbucketcrawler1",
#                "arn:aws:s3:::datacollectbucketcrawler1/*"
#            ]
#        },
#        {
#              "Effect": "Allow",
#              "Action": [
#                "logs:CreateLogGroup",
#                "logs:CreateLogStream",
#                "logs:PutLogEvents",
#                "logs:DescribeLogStreams"
#            ],
#              "Resource": [
#                "arn:aws:logs:*:*:*"
#            ]
#        }
#    ]
#}
#EOF
#}
#
#resource "aws_iam_role" "task_execution_role" {
#  name = "task_role_scrapeapidash"
#  assume_role_policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [
#      {
#        Action = "sts:AssumeRole"
#        Effect = "Allow"
#        Sid    = ""
#        Principal = {
#          Service = "ecs-tasks.amazonaws.com"
#        }
#      },
#    ]
#  })
#}
#
#resource "aws_iam_role_policy_attachment" "S3_automation_move_objects" {
#  role       = aws_iam_role.task_execution_role.name
#  policy_arn = aws_iam_policy.task_execution_policy.arn
#}

### SELENIUM TASK AND EXCUTION ROLES ###
resource "aws_iam_policy" "sel_execution_policy" {
  name = "sel_execution_policy"
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
}

resource "aws_iam_role" "sel_execution_role" {
  name = "sel_execution_role"
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
}

resource "aws_iam_role_policy_attachment" "sel_execution_role_attachment" {
  role       = aws_iam_role.sel_execution_role.name
  policy_arn = aws_iam_policy.sel_execution_policy.arn
}


variable "cars_data_s3_bucket_arn" {
  default = ""
}
resource "aws_iam_policy" "sel_task_policy" {
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
}

resource "aws_iam_role" "sel_task_role" {
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
}

resource "aws_iam_role_policy_attachment" "sel_task_role_attachment" {
  role       = aws_iam_role.sel_task_role.name
  policy_arn = aws_iam_policy.sel_task_policy.arn
}
