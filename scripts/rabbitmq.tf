resource "kubernetes_deployment" "rabbit" {
  metadata {
    name = "scalable-rabbit"
    labels = {
      App = "ScalableRabbitMQ"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "ScalableRabbitMQ"
      }
    }
    template {
      metadata {
        labels = {
          App = "ScalableRabbitMQ"
        }
      }
      spec {
        container {
          image = "rabbitmq:3.8.5-management"
          name  = "rabbit"

          port {
            container_port = 5672
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "rabbit" {
  metadata {
    name = "rabbit"
  }
  spec {
    selector = {
      App = kubernetes_deployment.rabbit.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 5672
      target_port = 5672
    }

    type = "LoadBalancer"
  }
}

output "rabbitservice_ip" {
  value = kubernetes_service.rabbit.status.0.load_balancer.0.ingress.0.hostname
}

