

# Backend Record (Private A Record)
resource "aws_route53_record" "backend" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${var.sub_domain_names[0]}.${var.domain_name}" 
  type    = "A"
  ttl     = 300
  records = ["10.0.2.63"]
}

# Database Record (Private A Record)
resource "aws_route53_record" "database" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${var.sub_domain_names[1]}.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = ["10.0.1.214"]
}

# Expense Record (Alias → ALB)
resource "aws_route53_record" "expense" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${var.sub_domain_names[2]}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.app_alb.dns_name
    zone_id                = aws_lb.app_alb.zone_id
    evaluate_target_health = true
  }
}
