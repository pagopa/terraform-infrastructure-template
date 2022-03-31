terraform {
  required_version = ">=1.0.6"
  required_providers {
    azurerm = {
      version = "= 2.99.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.10.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.7.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.4.1"
    }
  }

  backend "azurerm" {}
}

data "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = format("%s-aks", local.project)
  resource_group_name = format("%s-aks-rg", local.project)
}

provider "kubernetes" {
  config_path = "${var.k8s_kube_config_path_prefix}/config-${data.azurerm_kubernetes_cluster.aks_cluster.name}"
}

provider "helm" {
  kubernetes {
    config_path = "${var.k8s_kube_config_path_prefix}/config-${data.azurerm_kubernetes_cluster.aks_cluster.name}"
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}
