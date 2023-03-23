resource "aws_lambda_function" "terminate_redundant_instances" {
  filename         = "terminate_redundant_instances.zip"
  function_name    = "terminate_redundant_instances"
  handler          = "index.lambda_handler"
  role             = aws_iam_role.lambda_assume.arn
  runtime          = "python3.9"
}
