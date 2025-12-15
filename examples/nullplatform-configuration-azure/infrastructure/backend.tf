################################################################################
# Backend Configuration - Infrastructure
################################################################################

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-nullplatform-pocs-shared" # Resource group del storage account
    storage_account_name = "nullplatformdemos"           # Nombre del storage account
    container_name       = "edenred-poc"                 # Nombre del container
    key                  = "infrastructure.tfstate"
  }
}
