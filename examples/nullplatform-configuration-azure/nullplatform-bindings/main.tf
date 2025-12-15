
module "code_repository" {
  source                 = "git::https://github.com/nullplatform/tofu-modules.git//nullplatform/code_repository?ref=v1.12.4"
  np_api_key             = var.np_api_key
  nrn                    = var.nrn
  git_provider           = "github"
  github_organization    = var.github_organization
  github_installation_id = var.github_installation_id
}

module "asset_repository" {
  source       = "git::https://github.com/nullplatform/tofu-modules.git//nullplatform/asset/docker_server?ref=v1.12.4"
  nrn          = var.nrn
  np_api_key   = var.np_api_key
  login_server = var.login_server
  path         = var.path
  username     = var.username
  password     = var.password
}

module "cloud_provider" {
  source                          = "git::https://github.com/nullplatform/tofu-modules.git///nullplatform/cloud/azure/cloud?ref=v1.12.4"
  nrn                             = var.nrn
  domain_name                     = local.domain_name
  dimensions                      = var.dimensions
  azure_resource_group_name       = data.terraform_remote_state.infrastructure.outputs.resource_group_name
  private_dns_resource_group_name = data.terraform_remote_state.infrastructure.outputs.resource_group_name
  private_domain_name             = local.domain_name
}


###############################################################################
# Channel | Typically the cluster NRN level and dimensions
###############################################################################
module "scope_definition_channel_association" {
  source                     = "git::https://github.com/nullplatform/tofu-modules.git//nullplatform/scope_definition_agent_association?ref=v1.12.4"
  nrn                        = var.nrn
  np_api_key                 = var.np_api_key
  service_specification_id   = data.terraform_remote_state.nullplatform.outputs.service_specification_id
  service_specification_slug = data.terraform_remote_state.nullplatform.outputs.service_slug
  tags_selectors             = var.tags_selectors
}
