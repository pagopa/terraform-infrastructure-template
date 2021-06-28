terraform {
  required_version = ">=1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.60.0"
    }
  }

  backend "azurerm" {}
}
provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

locals {
  project = format("%s-%s", var.prefix, var.env_short)
}
