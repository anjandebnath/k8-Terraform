# create ECR repository
resource "aws_ecr_repository" "stream_repo" {
  # name has to be unique  
  name = "streaming"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = "dev"
    Project     = "Stream"
  }
}


# build docker image
resource "docker_image" "myapp" {
  name = "${aws_ecr_repository.stream_repo.repository_url}:latest"

  build {
    context    = "../video-streaming"
    dockerfile = "Dockerfile-prod"
  }
}


# push to ECR
resource "docker_registry_image" "registry" {
  name = docker_image.myapp.name
}