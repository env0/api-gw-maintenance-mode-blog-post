resource "aws_route53_record" "api_dns_record" {
  zone_id = var.route53_zone_id
  name    = var.route53_suffix_domain_name
  type    = "A"
  alias {
    name                   = aws_api_gateway_domain_name.domain_name.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.domain_name.regional_zone_id
    evaluate_target_health = false
  }
}