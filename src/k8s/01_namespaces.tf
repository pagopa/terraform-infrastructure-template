resource "kubernetes_namespace" "ingress" {
  metadata {
    name = "ingress"
  }
}

resource "kubernetes_namespace" "platform_namespace" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_namespace" "helm_template" {
  metadata {
    name = "helm-template"
  }
}
