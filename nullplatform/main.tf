###############################################################################
# K8s Scope Definition | Set this at organization level
###############################################################################
module "scope_definition" {
  source       = "git::https://github.com/nullplatform/tofu-modules.git//nullplatform/scope_definition?ref=v1.12.4"
  nrn          = var.nrn
  np_api_key   = var.np_api_key
  service_path = var.service_path
}

module "scope_definition_scheduled_task" {
  source                   = "git::https://github.com/nullplatform/tofu-modules.git//nullplatform/scope_definition?ref=v1.12.7"
  nrn                      = var.nrn
  np_api_key               = var.np_api_key
  service_path             = var.service_path_scheduled_task
  service_spec_name        = "Scheduled Task"
  service_spec_description = "Allows you to deploy periodic jobs in Kubernetes"
  action_spec_names = [
    "create-scope",
    "delete-scope",
    "start-initial",
    "start-blue-green",
    "finalize-blue-green",
    "rollback-deployment",
    "delete-deployment",
    "trigger"
  ]
}

module "dimensions" {
  source       = "git::https://github.com/nullplatform/tofu-modules.git///nullplatform/dimensions?ref=v1.12.4"
  nrn          = var.nrn
  np_api_key   = var.np_api_key
  environments = var.environments
}

module "service_definition_endpoint_exposer" {
  source           = "git::https://github.com/nullplatform/tofu-modules.git//nullplatform/service_definition?ref=v1.20.2"
  nrn              = var.nrn
  np_api_key       = var.np_api_key
  git_repo         = "nullplatform/services"
  git_ref          = "feature/endpoint-exposer"
  git_service_path = "endpoint-exposer"
  service_name     = "Endpoint Exposer"

  service_description = "Endpoint Exposer Service to expose Endpoints"
  use_tpl_files       = true # Set to true if using .tpl files, false for .json files
  tags_selectors = var.tags_selectors
}

