terraform {
  required_version = ">=0.15.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.60.0"
    }
  }

  # terraform cloud.
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "PagoPa"
    workspaces {
      prefix = "prefix-"
    }
  }
}
provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {
}

locals {
  project = format("%s-%s", var.prefix, var.env_short)
}
