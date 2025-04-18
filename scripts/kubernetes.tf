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

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.aws_eks_cluster.cluster.name
    ]
  }
}

