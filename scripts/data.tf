# get aws identity from terraform state
data "aws_caller_identity" "current" {}

# get authorization credentials to push to ecr
data "aws_ecr_authorization_token" "token" {}



