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
  #when use module aks
  host                   = module.aks.host
  client_certificate     = base64decode(module.aks.admin_client_certificate)
  client_key             = base64decode(module.aks.admin_client_key)
  cluster_ca_certificate = base64decode(module.aks.admin_cluster_ca_certificate)
  #when use data
  # host                   = data.azurerm_kubernetes_cluster.this.kube_admin_config[0].host
  # client_certificate     = base64decode(data.azurerm_kubernetes_cluster.this.kube_admin_config[0].client_certificate)
  # client_key             = base64decode(data.azurerm_kubernetes_cluster.this.kube_admin_config[0].client_key)
  # cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.this.kube_admin_config[0].cluster_ca_certificate)
}

provider "helm" {
  kubernetes = {
    #when use module aks
    host                   = module.aks.host
    client_certificate     = base64decode(module.aks.admin_client_certificate)
    client_key             = base64decode(module.aks.admin_client_key)
    cluster_ca_certificate = base64decode(module.aks.admin_cluster_ca_certificate)
    #when use data
    # host                   = data.azurerm_kubernetes_cluster.this.kube_admin_config[0].host
    # client_certificate     = base64decode(data.azurerm_kubernetes_cluster.this.kube_admin_config[0].client_certificate)
    # client_key             = base64decode(data.azurerm_kubernetes_cluster.this.kube_admin_config[0].client_key)
    # cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.this.kube_admin_config[0].cluster_ca_certificate)
  }
}