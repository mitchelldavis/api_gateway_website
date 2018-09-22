provider "aws" {
	region = "us-west-2"
}

data "archive_file" "test_src" {
	type        = "zip"
	source_dir = "${path.module}/src"
	output_path = "${path.module}/lambda.zip"
}

module "test_api" {
	source = "git::https://github.com/mitchelldavis/api_gateway_website.git"
	name = "awesome"
	lambda_package = "${data.archive_file.test_src.output_path}"
	lambda_package_hash = "${data.archive_file.test_src.output_base64sha256}"
	lambda_runtime = "nodejs8.10"
	lambda_handler = "main.handler"
	lambda_tags {
		Name = "My Awesome Test Website"
	}
	deployment_path = "awesome"
}

output "base_url" {
	value = "${module.test_api.base_url}"
}
