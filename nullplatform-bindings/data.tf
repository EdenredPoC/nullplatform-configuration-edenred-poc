################################################################################
# Remote State - Infrastructure
################################################################################

data "terraform_remote_state" "infrastructure" {
  backend = "azurerm"
  config = {
    resource_group_name  = "gti-ctp-snbx-ccoe-rg"
    storage_account_name = "gtictptfstsas"
    container_name       = "terraformstate"
    key                  = "nullplatformpocinfra.tfstate"
  }
}

################################################################################
# Remote State - Nullplatform
################################################################################

data "terraform_remote_state" "nullplatform" {
  backend = "azurerm"
  config = {
    resource_group_name  = "gti-ctp-snbx-ccoe-rg"
    storage_account_name = "gtictptfstsas"
    container_name       = "terraformstate"
    key                  = "nullplatformpoc.tfstate"
  }
}
