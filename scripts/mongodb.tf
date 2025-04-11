resource "kubernetes_deployment" "mongodb" {
  metadata {
    name = "scalable-mongo-db"
    labels = {
      App = "ScalableMongoDb"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "ScalableMongoDb"
      }
    }
    template {
      metadata {
        labels = {
          App = "ScalableMongoDb"
        }
      }
      spec {
        container {
          image = "mongo:4.2.8"
          name  = "scalable-mongo-db"

          port {
            container_port = 27017
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

resource "kubernetes_service" "mongodb" {
  metadata {
    name = "mongo-db"
  }
  spec {
    selector = {
      App = kubernetes_deployment.mongodb.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 27017
      target_port = 27017
    }

    type = "LoadBalancer"
  }
}


output "mongoservice_ip" {
  value = kubernetes_service.mongodb.status.0.load_balancer.0.ingress.0.hostname
}
