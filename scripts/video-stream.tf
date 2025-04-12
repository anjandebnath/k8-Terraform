# Deploy video-streaming microservice on Kubernetes
locals {
  service_name = "video-streaming"
  image_tag = "latest"
}

# kubernetes secret to store ecr authorization credentials for private microservice docker image
resource "kubernetes_secret" "ecr_docker_config" {
  metadata {
    name = "ecr-docker-config"
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${data.aws_ecr_authorization_token.token.proxy_endpoint}" = {
          auth = data.aws_ecr_authorization_token.token.authorization_token
        }
      }
    })
  }
}


# Schedule a deployment
resource "kubernetes_deployment" "service_deployment" {
  
  depends_on = [ docker_registry_image.registry ]
  
  metadata {
    name = local.service_name
    labels = {
      App = local.service_name
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        App = local.service_name
      }
    }

    template {
      metadata {
        labels = {
          App = local.service_name
        }
      }

      spec {

        container {
          image = "${aws_ecr_repository.stream_repo.repository_url}:latest" #"264268443219.dkr.ecr.us-east-1.amazonaws.com/streaming:latest"
          name  = local.service_name
          image_pull_policy = "Always"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }

        image_pull_secrets {
              name = kubernetes_secret.ecr_docker_config.metadata[0].name
          }
      }
    }
  }
}


# Schedule a service
# Exposes the service to the external world using an AWS load balancer.
# This creates a LoadBalancer, which routes traffic from the external load balancer to pods with the matching selector.
resource "kubernetes_service" "service" {
  metadata {
    name = local.service_name
  }
  spec {
    selector = {
      App = kubernetes_deployment.service_deployment.spec.0.template.0.metadata[0].labels.App
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

/*
Next, create an output which will display the IP address you can use to access the service. 
Hostname-based (AWS) and IP-based (Azure, Google Cloud) load balancers reference different values.
*/
output "streamservice_ip" {
  value = kubernetes_service.service.status.0.load_balancer.0.ingress.0.hostname
}