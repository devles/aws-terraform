resource "aws_alb" "app_alb" {
  name 				= "appALB-${var.environment}"
  internal 			= "false"
  security_groups 	= ["${aws_security_group.private_sg0.id}"]
  subnets			= [
    "${aws_subnet.private0.id}",
    "${aws_subnet.private1.id}"
  ]
  tags {
    Network = "Public"
  }
}

resource "aws_alb_target_group" "app_alb_target_group_component1" {
  name = "AppTargetGroup-${var.environment}"
  port = "80"
  protocol = "HTTP"
  vpc_id = "${aws_vpc.app_vpc.id}"
  health_check {
    interval = "10"
    path = "/status"
    protocol = "HTTP"
    timeout = "5"
    healthy_threshold = "2"
    unhealthy_threshold = "2"
  }
}

resource "aws_alb_listener" "app_alb_http_listener" {
  load_balancer_arn = "${aws_alb.app_alb.arn}"
  port = "80"
  protocol = "HTTP"
  default_action {
    target_group_arn = "${aws_alb_target_group.app_alb_target_group_component1.arn}"
    type = "forward"
  }
}

resource "aws_alb_listener_rule" "app_alb_listener_rule" {
  action {
    target_group_arn = "${aws_alb_target_group.app_alb_target_group_component1.arn}"
    type = "forward"
  }
  condition {
    field  = "path-pattern"
    values = ["/"]
  }
  listener_arn = "${aws_alb_listener.app_alb_http_listener.arn}"
  priority = "1"
}

