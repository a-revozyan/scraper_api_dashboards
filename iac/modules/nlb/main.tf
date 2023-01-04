resource "aws_lb" "nlb" {
  name               = "nlb1-${var.env}"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.frontend_subnet_ids
  enable_deletion_protection = false
  tags = {
    Name = "${var.env}-nlb"
  }
}

resource "aws_lb_target_group" "nlb_tg_api" {
  depends_on  = [
    aws_lb.nlb
  ]
  lifecycle {
    create_before_destroy = true
  }
  name        = "nlb-${var.env}-tg-api"
  port        = var.api_port_target_group
  protocol    = var.tcp
  vpc_id      = var.vpc_id
  target_type = var.target_type

  tags = {
    Name = "${var.env}-nlb_tg"
  }
}

resource "aws_lb_target_group" "nlb_tg_dash" {
  depends_on  = [
    aws_lb.nlb
  ]
  lifecycle {
    create_before_destroy = true
  }
  name        = "nlb-${var.env}-tg-dash"
  port        = var.dash_port_target_group
  protocol    = var.tcp
  vpc_id      = var.vpc_id
  target_type = var.target_type

  tags = {
    Name = "${var.env}-nlb2_tg"
  }
}

resource "aws_lb_listener" "nlb_listener_api" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = var.api_port_target_group
  protocol          = var.tcp

  default_action {
    target_group_arn = aws_lb_target_group.nlb_tg_api.arn
    type             = "forward"
  }
  tags = {
    Name = "${var.env}-nlb_listener_api"
  }
}

resource "aws_lb_listener" "nlb_listener_dash" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = var.dash_port_target_group
  protocol          = var.tcp

  default_action {
    target_group_arn = aws_lb_target_group.nlb_tg_dash.arn
    type             = "forward"
  }
  tags = {
    Name = "${var.env}-nlb_listener_dash"
  }
}