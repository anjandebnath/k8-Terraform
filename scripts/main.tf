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


# build docker image video-streaming
resource "docker_image" "myapp" {
  name = "${aws_ecr_repository.stream_repo.repository_url}:latest"

  build {
    context    = "../video-streaming"
    dockerfile = "Dockerfile-prod"
  }
}


# push image to ECR
resource "docker_registry_image" "registry" {
  name = docker_image.myapp.name
}




# kubernetes secret to store ecr athorization credentials
/*
resource "kubernetes_secret" "docker" {
  metadata {
    name = "docker-cfg"
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
       "${data.aws_ecr_authorization_token.token.proxy_endpoint}" = {
          auth = "${data.aws_ecr_authorization_token.token.authorization_token}"
        }
      }
    })
  }
}
*/