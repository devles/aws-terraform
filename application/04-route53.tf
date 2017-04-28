variable "domain_names" {
  type = "map"
  default = {
    "test" = "test.catstongue.co.uk"
    "prod" = "prod.catstongue.co.uk"
  }
}

variable "alb_endpoint" {
  description = "If true route53 endpoint is alb"
}

variable "cf_endpoint" {
  description = "If true route53 endpoint is CloudFront"
}

resource "aws_route53_record" "environment_endpoint" {
  zone_id = "Z2MTHU4FF0COVY"
  name = "${lookup(var.domain_names, var.environment)}"
  type = "A"
  alias {
    zone_id = "${aws_alb.app_alb.zone_id}"
    name = "${aws_alb.app_alb.dns_name}"
    evaluate_target_health = false
  }
}
