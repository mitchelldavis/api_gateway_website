resource "aws_api_gateway_rest_api" "rest_api" {
	name        = "${var.name}_rest_api"
	description = "${var.name} Serverless Rest API"
}

resource "aws_api_gateway_resource" "proxy" {
	rest_api_id = "${aws_api_gateway_rest_api.rest_api.id}"
	parent_id   = "${aws_api_gateway_rest_api.rest_api.root_resource_id}"
	path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
	rest_api_id   = "${aws_api_gateway_rest_api.rest_api.id}"
	resource_id   = "${aws_api_gateway_resource.proxy.id}"
	http_method   = "ANY"
	authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
	rest_api_id = "${aws_api_gateway_rest_api.rest_api.id}"
	resource_id = "${aws_api_gateway_method.proxy.resource_id}"
	http_method = "${aws_api_gateway_method.proxy.http_method}"

	integration_http_method = "POST"
	type                    = "AWS_PROXY"
	uri                     = "${aws_lambda_function.lambda.invoke_arn}"
}

resource "aws_api_gateway_method" "proxy_root" {
	rest_api_id   = "${aws_api_gateway_rest_api.rest_api.id}"
	resource_id   = "${aws_api_gateway_rest_api.rest_api.root_resource_id}"
	http_method   = "ANY"
	authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_root" {
	rest_api_id = "${aws_api_gateway_rest_api.rest_api.id}"
	resource_id = "${aws_api_gateway_method.proxy_root.resource_id}"
	http_method = "${aws_api_gateway_method.proxy_root.http_method}"

	integration_http_method = "POST"
	type                    = "AWS_PROXY"
	uri                     = "${aws_lambda_function.lambda.invoke_arn}"
}

resource "aws_api_gateway_deployment" "api_gateway_deployment" {
	depends_on = [
		"aws_api_gateway_integration.lambda",
		"aws_api_gateway_integration.lambda_root",
	]

	rest_api_id = "${aws_api_gateway_rest_api.rest_api.id}"
	stage_name  = "${var.deployment_path}"
}

resource "aws_lambda_permission" "apigw" {
	statement_id  = "AllowAPIGatewayInvoke"
	action        = "lambda:InvokeFunction"
	function_name = "${aws_lambda_function.lambda.arn}"
	principal     = "apigateway.amazonaws.com"

	# The /*/* portion grants access from any method on any resource
	# within the API Gateway "REST API".
	source_arn = "${aws_api_gateway_deployment.api_gateway_deployment.execution_arn}/*/*"
}
