################################################################################
# Remote State - Infrastructure
################################################################################

data "terraform_remote_state" "infrastructure" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-nullplatform-pocs-shared"
    storage_account_name = "nullplatformdemos"
    container_name       = "edenred-poc"
    key                  = "infrastructure.tfstate"
  }
}

################################################################################
# Remote State - Nullplatform
################################################################################

data "terraform_remote_state" "nullplatform" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-nullplatform-pocs-shared"
    storage_account_name = "nullplatformdemos"
    container_name       = "edenred-poc"
    key                  = "nullplatform.tfstate"
  }
}
