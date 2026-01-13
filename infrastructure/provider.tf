terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.41.0"
    }
    nullplatform = {
      source  = "nullplatform/nullplatform"
      version = "~> 0.0.75"
    }
  }
}

provider "azurerm" {
  features {}
  use_cli         = true
  subscription_id = var.azure_subscription_id
  # resource_provider_registrations = "none" # opcional si lo usabas
}

provider "nullplatform" {
  api_key = var.np_api_key
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}
provider "helm" {
  kubernetes = {
    config_path    = var.kubeconfig_path
    config_context = var.kube_context
  }
}