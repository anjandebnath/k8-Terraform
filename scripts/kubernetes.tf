# this configuration uses terraform_remote_state to retrieve outputs from your EKS cluster and targets your Terraform resources
data "terraform_remote_state" "eks" {
  backend = "local"

  config = {
    path = "../scripts/terraform.tfstate"
  }
}

# Retrieve EKS cluster information
/*
provider "aws" {
  region = data.terraform_remote_state.eks.outputs.region
}
*/

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


# Deploy nginx server
resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "scalable-nginx-example"
    labels = {
      App = "ScalableNginxExample"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "ScalableNginxExample"
      }
    }
    template {
      metadata {
        labels = {
          App = "ScalableNginxExample"
        }
      }
      spec {
        container {
          image = "nginx:1.7.8"
          name  = "example"

          port {
            container_port = 80
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

# Exposes the service to the external world using an AWS load balancer.
# This creates a LoadBalancer, which routes traffic from the external load balancer to pods with the matching selector.
resource "kubernetes_service" "nginx" {
  metadata {
    name = "nginx-example"
  }
  spec {
    selector = {
      App = kubernetes_deployment.nginx.spec.0.template.0.metadata[0].labels.App
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
output "lb_ip" {
  value = kubernetes_service.nginx.status.0.load_balancer.0.ingress.0.hostname
}


