resource "aws_iam_role" "lambda_exec" {
  name = "${var.name}_lambda_exec"
  assume_role_policy = "${var.lambda_role}"
}

resource "aws_iam_role_policy" "iam_policy_for_lambda_exec" {
	name = "${var.name}_policy_for_lambda_exec"
	role = "${aws_iam_role.lambda_exec.id}"
	policy = "${var.lambda_policy}"
}

resource "aws_lambda_function" "lambda" {
	filename = "${var.lambda_package}"
	function_name = "${var.name}_main_lambda"
	runtime = "${var.lambda_runtime}"
	role = "${aws_iam_role.lambda_exec.arn}"
	handler = "${var.lambda_handler}"
	source_code_hash = "${var.lambda_package_hash}"
	timeout = "${var.lambda_timeout}"
	environment {
		variables = "${var.lambda_environment}"
	}
}
