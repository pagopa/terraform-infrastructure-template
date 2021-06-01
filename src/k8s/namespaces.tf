resource "kubernetes_namespace" "ingress" {
  metadata {
    name = "ingress"
  }
}
