resource "aws_route53_record" "alb_alias" {
  zone_id = var.zone_id
  name    = var.domain_name      # mydomain312.com
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id 
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cname_www" {
  zone_id = var.zone_id
  name    = "www.${var.domain_name}"           # "www.mydomain312.com"
  type    = "CNAME"
  ttl     = 300
  records = [var.alb_dns_name]                 # that one for DNS-имя ALB
}