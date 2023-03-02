resource "aws_cloudwatch_event_target" "ec2_kill_function" {
  target_id = "ec2_kill_function"
  rule      = aws_cloudwatch_event_rule.tb_kill_ec2.name
  arn       = aws_lambda_function.terminate_redundant_instances.arn
}

resource "aws_cloudwatch_event_rule" "tb_kill_ec2" {
  name        = "tb_kill_ec2"
  description = "Terminate all EC2 which stopped for 30 days"
  schedule_expression = "cron(* * * * ? *)"
}