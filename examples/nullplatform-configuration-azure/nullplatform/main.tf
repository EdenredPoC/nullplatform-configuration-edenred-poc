###############################################################################
# K8s Scope Definition | Set this at organization level
###############################################################################
module "scope_definition" {
  source       = "git::https://github.com/nullplatform/tofu-modules.git//nullplatform/scope_definition?ref=v1.12.4"
  nrn          = var.nrn
  np_api_key   = var.np_api_key
  service_path = var.service_path
}
