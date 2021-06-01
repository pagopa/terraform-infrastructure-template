# from Microsoft docs https://docs.microsoft.com/it-it/azure/aks/ingress-internal-ip
resource "helm_release" "ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "3.31.0"
  namespace  = kubernetes_namespace.ingress.metadata[0].name

  values = [
    "${templatefile("${path.module}/ingress/loadbalancer.yaml.tpl", { load_balancer_ip = var.ingress_load_balancer_ip })}"
  ]

  set {
    name  = "controller.replicaCount"
    value = var.ingress_replica_count
  }

  set {
    name  = "controller.nodeSelector.beta\\.kubernetes\\.io/os"
    value = "linux"
  }

  set {
    name  = "defaultBackend.nodeSelector.beta\\.kubernetes\\.io/os"
    value = "linux"
  }

  set {
    name  = "controller.admissionWebhooks.patch.nodeSelector.beta\\.kubernetes\\.io/os"
    value = "linux"
  }
}
