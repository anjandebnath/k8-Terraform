output "region" {
  description = "AWS region"
  value       = var.region
}


output "ecr_repository_url" {

  # aws_account_id.dkr.ecr.us-east-1.amazonaws.com/flixtube
  description = "AWS ECR repository"
  value       = aws_ecr_repository.stream_repo.repository_url
}