terraform {
  required_version = ">=1.1.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.90.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.10.0"
    }

  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}
