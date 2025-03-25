terraform {
    required_providers {
        aws = {
            # For each provider, the source attribute defines an optional hostname, a namespace, and the provider type.
            source  = "hashicorp/aws"
            # If you do not specify a provider version, Terraform will automatically download the most recent version
            version = "~> 5.92.0"
    }
  }
  required_version = ">= 1.2.0"
}


# A provider is a plugin that Terraform uses to create and manage your resources.
provider "aws" {
  region  = ""
  access_key = ""
  secret_key = ""
}

# Use resource blocks to define components of your infrastructure.
# Resource blocks have two strings before the block: the resource type and the resource name.
resource "aws_ecr_repository" "my_repo" {
  # name has to be unique  
  name = "flixtube"
  
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = "dev"
    Project     = "Stream"
  }
}

#Query the outputs with the command: `terraform output`
output "ecr_repository_url" {

  # aws_account_id.dkr.ecr.us-east-1.amazonaws.com/flixtube
 
  value = aws_ecr_repository.my_repo.repository_url
}






# VPC for EKS
resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Subnets for EKS
resource "aws_subnet" "eks_subnets" {
  count = 2
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = element(["us-east-1a", "us-east-1b"], count.index)
}

# IAM Role for EKS Cluster
resource "aws_iam_role" "eks_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

# IAM Role for EKS Node Group
resource "aws_iam_role" "node_role" {
  name = "eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

# EKS Cluster
resource "aws_eks_cluster" "flixtube" {
  name     = "flixtube"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = aws_subnet.eks_subnets[*].id
  }

  version = "1.32"
}

# EKS Node Group
resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.flixtube.name
  node_group_name = "default"
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = aws_subnet.eks_subnets[*].id

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t3.medium"] # Closest equivalent to Azure Standard_B2ms
}

# Outputs
output "cluster_endpoint" {
  value = aws_eks_cluster.flixtube.endpoint
}

output "cluster_name" {
  value = aws_eks_cluster.flixtube.name
}


