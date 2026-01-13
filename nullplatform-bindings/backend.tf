################################################################################
# Backend Configuration - Nullplatform Bindings
################################################################################

terraform {
  backend "azurerm" {
    resource_group_name  = "gti-ctp-snbx-ccoe-rg" # Resource group del storage account
    storage_account_name = "gtictptfstsas"           # Nombre del storage account
    container_name       = "terraformstate"                 # Nombre del container
    key                  = "nullplatformpocbindings.tfstate"
  }
}
