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

resource "aws_lb_target_group" "nlb_tg" {
  depends_on  = [
    aws_lb.nlb
  ]
  lifecycle {
    create_before_destroy = true
  }
  name        = "nlb1-${var.env}-tg"
  port        = 5050
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  tags = {
    Name = "${var.env}-nlb_tg"
  }
}

resource "aws_lb_target_group" "nlb_tg2" {
  depends_on  = [
    aws_lb.nlb
  ]
  lifecycle {
    create_before_destroy = true
  }
  name        = "nlb2-${var.env}-tg"
  port        = 80
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  tags = {
    Name = "${var.env}-nlb2_tg"
  }
}

# Redirect all traffic from the NLB to the target group
resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 5050
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.nlb_tg.arn
    type             = "forward"
  }
  tags = {
    Name = "${var.env}-nlb_listener"
  }
}

resource "aws_lb_listener" "nlb_listener2" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.nlb_tg2.arn
    type             = "forward"
  }
  tags = {
    Name = "${var.env}-nlb_listener2"
  }
}