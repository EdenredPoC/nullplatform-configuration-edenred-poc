module "resource_group" {
  source              = "git::https://github.com/nullplatform/tofu-modules.git///infrastructure/azure/resource_group?ref=v1.20.1"
  resource_group_name = local.resource_group_name
  location            = var.location
  subscription_id     = var.azure_subscription_id
  tags                = {}
}


###############################################################################
# Agent | At least one per cluster
################################################################################
module "agent" {
  source                  = "git::https://github.com/nullplatform/tofu-modules.git//nullplatform/agent?ref=v1.20.1"
  cluster_name            = local.cluster_name
  cloud_provider          = var.cloud_provider
  nrn                     = var.nrn
  image_tag               = var.image_tag
  tags_selectors          = var.tags_selectors
  private_hosted_zone_rg  = local.resource_group_name
  private_gateway_name    = var.private_gateway_name
  public_gateway_name     = var.public_gateway_name
  azure_resource_group    = local.resource_group_name
  azure_subscription_id   = var.azure_subscription_id
  azure_client_secret     = var.azure_client_secret
  azure_client_id         = var.azure_client_id
  azure_tenant_id         = var.azure_tenant_id
  dns_type                = var.dns_type
  domain                  = local.domain_name
  image_pull_secrets      = var.image_pull_secrets
  use_account_slug        = var.use_account_slug
  service_template        = var.service_template
  initial_ingress_path    = var.initial_ingress_path
  blue_green_ingress_path = var.blue_green_ingress_path
  agent_repos_extra       = ["https://github.com/nullplatform/services"]

}

module "base" {
  source       = "git::https://github.com/nullplatform/tofu-modules.git///nullplatform/base?ref=v1.20.1"
  np_api_key   = var.np_api_key
  nrn          = var.nrn
  k8s_provider = var.k8s_provider
  gateway_internal_enabled = true
}

module "cert_manager" {
  source                 = "git::https://github.com/nullplatform/tofu-modules.git///infrastructure/commons/cert_manager?ref=v1.20.1"
  cloud_provider         = "cloudflare"
  account_slug           = var.account_slug
  hosted_zone_name       = local.domain_name
  private_domain_name    = local.domain_name
  cloudflare_secret_name = var.cloudflare_secret_name
  cloudflare_token       = var.cloudflare_token
  cert_manager_namespace = var.cert_manager_namespace

  depends_on = [module.base]
}

module "istio" {
  source = "git::https://github.com/nullplatform/tofu-modules.git///infrastructure/commons/istio?ref=v1.20.1"
}

module "external_dns" {
  source                 = "git::https://github.com/nullplatform/tofu-modules.git///infrastructure/commons/external_dns?ref=v1.20.2"
  dns_provider_name      = "cloudflare"
  domain_filters         = "nullimplementation.com"
  external_dns_namespace = "external-dns"
  cloudflare_token       = var.cloudflare_token
}

module "prometheus" {
  source               = "git::https://github.com/nullplatform/tofu-modules.git//nullplatform/prometheus?ref=v1.12.7"
  np_api_key           = var.np_api_key
  nrn                  = var.nrn
  install_prometheus   = var.install_prometheus
  dimensions           = var.prometheus_dimensions
  prometheus_namespace = var.prometheus_namespace

  # Temporary fix
  prometheus_url = ""
}