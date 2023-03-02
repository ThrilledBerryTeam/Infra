resource "aws_iam_role" "lambda_assume" {
  name = "lambda_assume"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
  })

  tags = {
    Company = "CompanyName"
    Project = "EC2 Security"
  }
}

resource "aws_iam_policy" "ec2_policy" {
  name        = "ec2_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "terraform_lambda_policy" {
  role       = aws_iam_role.lambda_assume.name
  policy_arn = aws_iam_policy.ec2_policy.arn
}

#cloudwatch role 

resource "aws_iam_role" "cloudwatch_assume" {
  name = "cloudwatch_assume"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudwatch.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
  })

  tags = {
    Company = "CompanyName"
    Project = "EC2 Security"
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "lambda:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cloudwatch_to_lambda" {
  role       = aws_iam_role.cloudwatch_assume.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}




