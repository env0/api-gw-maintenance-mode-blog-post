resource "aws_api_gateway_domain_name" "domain_name" {
  certificate_arn = var.certificate_arn
  domain_name     = var.domain_name
}

resource "aws_api_gateway_base_path_mapping" "base_mapping" {
  api_id      = var.maintenance_mode ? aws_api_gateway_rest_api.maintenance_mode_api.id : aws_api_gateway_rest_api.api.id
  stage_name  = var.maintenance_mode ? aws_api_gateway_deployment.maintenance_mode_deployment.stage_name : aws_api_gateway_deployment.deployment.stage_name
  domain_name = aws_api_gateway_domain_name.domain_name.domain_name
  base_path   = "/"
}
