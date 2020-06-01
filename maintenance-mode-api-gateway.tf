resource "aws_api_gateway_rest_api" "maintenance_mode_api" {
  name        = "maintenance-mode-API"
  description = "This is my Maintenance mode API"
}

resource "aws_api_gateway_resource" "maintenance_mode_resource" {
  rest_api_id = aws_api_gateway_rest_api.maintenance_mode_api.id
  parent_id   = aws_api_gateway_rest_api.maintenance_mode_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "maintenance_mode_method" {
  rest_api_id   = aws_api_gateway_rest_api.maintenance_mode_api.id
  resource_id   = aws_api_gateway_resource.maintenance_mode_resource.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "maintenance_mode_integration" {
  rest_api_id          = aws_api_gateway_rest_api.maintenance_mode_api.id
  resource_id          = aws_api_gateway_resource.maintenance_mode_resource.id
  http_method          = aws_api_gateway_method.maintenance_mode_method.http_method
  type                 = "MOCK"
  timeout_milliseconds = 29000
  passthrough_behavior = "WHEN_NO_MATCH"
  request_templates = {
    "application/json" = <<EOF
    {"statusCode": 503}
EOF
  }
}

resource "aws_api_gateway_method_response" "maintenance_mode_response_503" {
  rest_api_id = aws_api_gateway_rest_api.maintenance_mode_api.id
  resource_id = aws_api_gateway_resource.maintenance_mode_resource.id
  http_method = aws_api_gateway_method.maintenance_mode_method.http_method
  status_code = "503"
}

resource "aws_api_gateway_integration_response" "maintenance_mode_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.maintenance_mode_api.id
  resource_id = aws_api_gateway_resource.maintenance_mode_resource.id
  http_method = aws_api_gateway_method.maintenance_mode_method.http_method
  status_code = aws_api_gateway_method_response.maintenance_mode_response_503.status_code

  # Transforms the backend JSON response to XML
  response_templates = {
    "application/json" = <<EOF
#set($inputRoot = $input.path('$')) { "message" : "Sorry for the inconvenience but we are performing some maintenance at the moment. We will be back online shortly!" }
EOF
  }
}

resource "aws_api_gateway_deployment" "maintenance_mode_deployment" {
  depends_on  = [aws_api_gateway_integration.maintenance_mode_integration]
  rest_api_id = aws_api_gateway_rest_api.maintenance_mode_api.id
  stage_name  = "prod"
}
