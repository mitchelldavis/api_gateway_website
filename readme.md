api_gateway_website
===================

This [Terraform](https://www.terraform.io/) module can be used to easily expose a lambda function built to expose web code.

Usage
-----

The below example references a nodejs application that is zipped up.  Notice that the module expects the user to zip up the source so that it's sha256 has can be used to distinguish when the source code has changed.

```terraform
data "archive_file" "test_src" {
	type        = "zip"
	source_dir = "${path.module}/src/test"
	output_path = "${path.module}/src/lambda.zip"
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
```

License
-------
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org>
