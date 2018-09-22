variable name {
	type = "string"
}

variable lambda_package {
	type = "string"
}

variable lambda_package_hash {
	type = "string"
}

variable lambda_runtime {
	type = "string"
}

variable lambda_handler {
	type = "string"
}

variable lambda_timeout {
	default = 20
}

variable lambda_tags {
	type = "map"
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
			"Resource": "*" }
	]
}
EOF
}

variable deployment_path {
	default = "test"
}
