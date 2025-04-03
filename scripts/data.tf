# get aws identity from terraform state
data "aws_caller_identity" "current" {}

# get authorization credentials to push to ecr
data "aws_ecr_authorization_token" "token" {}

# this configuration uses terraform_remote_state to retrieve outputs from your EKS cluster and targets your Terraform resources
data "terraform_remote_state" "eks" {
  backend = "local"

  config = {
    path = "../scripts/terraform.tfstate"
  }
}

# Retrieve EKS cluster information
data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}