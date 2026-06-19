resource "aws_lb" "web_alb" {
  name               = "terraform-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    var.web_sg
  ]

  subnets = [
    var.subnet1,
    var.subnet2
  ]
}

resource "aws_lb_target_group" "tg" {
  name     = "web-target-group"
  port     = 80
  protocol = "HTTP"

  vpc_id = var.vpc_id

}

resource "aws_lb_target_group_attachment" "web1" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.instance1
  port             = 80
}

resource "aws_lb_target_group_attachment" "web2" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.instance2
  port             = 80
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web_alb.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}