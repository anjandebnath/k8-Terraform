# A provider is a plugin that Terraform uses to create and manage your resources.
provider "aws" {
  region = var.region
}

provider "docker" {
    registry_auth {
        address  = local.aws_ecr_url
        username = data.aws_ecr_authorization_token.token.user_name
        password = data.aws_ecr_authorization_token.token.password
  }
}
