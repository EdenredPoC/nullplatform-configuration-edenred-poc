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
  source       = "git::https://github.com/nullplatform/tofu-modules.git//nullplatform/scope_definition?ref=v1.12.7"
  nrn          = var.nrn
  np_api_key   = var.np_api_key
  service_path = var.service_path_scheduled_task
  service_spec_name = "Scheduled Task"
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

module "service_definition_endpoint_exposer" {
  source       = "git::https://github.com/nullplatform/tofu-modules.git//services/endpoint-exposer?ref=feature/endpoint-exposer"
  nrn          = var.nrn
}



module "dimensions" {
  source       = "git::https://github.com/nullplatform/tofu-modules.git///nullplatform/dimensions?ref=v1.12.4"
  nrn          = var.nrn
  np_api_key   = var.np_api_key
  environments = var.environments
}



