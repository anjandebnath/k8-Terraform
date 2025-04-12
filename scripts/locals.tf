locals {
  tags = {
    created_by = "terraform"
  }

  # "<account??>.dkr.ecr.<region??>.amazonaws.com
  aws_ecr_url = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com"
  

}