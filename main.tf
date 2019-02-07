variable name {
	type = "string"
	description = "The unique identifier used throughout the module to name and identify different resources."
}

variable gateway_policy {
	type = "string"
	default = ""
	description = "JSON formatted policy document that controls access to the API Gateway. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide (https://www.terraform.io/docs/providers/aws/guides/iam-policy-documents.html)"
}

variable gateway_endpoint_configuration_types {
	type = "string"
	default = "EDGE"
	description = "Nested argument defining API endpoint configuration including endpoint type.  Values: EDGE (default), REGIONAL, PRIVATE"
}

variable lambda_package {
	type = "string"
	description = "A path to a zip file containing all the code needed for the lambda function. https://www.terraform.io/docs/providers/aws/r/lambda_function.html#filename"
}

variable lambda_package_hash {
	type = "string"
	description = "See https://www.terraform.io/docs/providers/aws/r/lambda_function.html#source_code_hash If you used the archive data resource for terraform, then the `output_base64sha256` attribute is a good choice for this input."
}

variable lambda_runtime {
	type = "string"
	description = "See https://www.terraform.io/docs/providers/aws/r/lambda_function.html#runtime"
}

variable lambda_handler {
	type = "string"
	description = "See https://www.terraform.io/docs/providers/aws/r/lambda_function.html#handler"
}

variable lambda_timeout {
	default = 20
	description = "See https://www.terraform.io/docs/providers/aws/r/lambda_function.html#timeout"
}

variable lambda_tags {
	type = "map"
	default = {
		source = "https://github.com/mitchelldavis/api_gateway_website"
	}
	description = "See https://www.terraform.io/docs/providers/aws/r/lambda_function.html#tags"
}

variable lambda_environment {
	type = "map"
	default = {
		source = "https://github.com/mitchelldavis/api_gateway_website"
	}
	description = "See https://www.terraform.io/docs/providers/aws/r/lambda_function.html#environment"
}

variable lambda_role {
	default = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Action": "sts:AssumeRole",
			"Principal": {
				"Service": "lambda.amazonaws.com"
			},
			"Effect": "Allow",
			"Sid": ""
		}
	]
}
EOF

	description = "The role definition the lambda function will execute under."
}

variable lambda_policy {
	default = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Action": [
				"logs:*"
			],
			"Effect": "Allow",
			"Resource": "*"
		}
	]
}
EOF

	description = "The policy document to attach to the role the lambda function will execute under."
}

variable deployment_path {
	default = "test"
	description = "See https://www.terraform.io/docs/providers/aws/r/api_gateway_deployment.html#stage_name"
}
