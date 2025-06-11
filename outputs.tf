output "alb_dns" { value = module.alb.dns_name }
output "application_url" { value = "http://${var.domain_name}" }