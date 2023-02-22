# module "s3_bucket" {
#   source = "terraform-aws-modules/s3-bucket/aws"
#   bucket_prefix = "${local.user}-bucket"
#   acl    = "private"

#   versioning = {
#     enabled = true
#   }

# }

resource "aws_s3_bucket" "tf_state_file" {
  bucket = "${var.company_name}-tf-state-file-3907"

  tags = {
    company_name        = var.company_name
    
  }
}

