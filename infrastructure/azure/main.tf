module "acr" {
  source                 = "git::https://github.com/nullplatform/tofu-modules.git///infrastructure/azure/acr?ref=v1.12.4"
  containerregistry_name = local.containerregistry_name
  resource_group_name    = module.resource_group.resource_group_name
  location               = var.location
  subscription_id        = var.azure_subscription_id
  sku                    = "Basic"
  #change to some number if sku is premium
  retention_policy_in_days = null

}

module "aks" {
  source              = "git::https://github.com/nullplatform/tofu-modules.git///infrastructure/azure/aks?ref=v1.17.1"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  cluster_name        = local.cluster_name
  subscription_id     = var.azure_subscription_id
  vnet_subnet_id      = module.vnet.subnet_ids_by_name["subnet-2"]
  vnet_id             = module.vnet.resource_id
  system_pool_vm_size = "Standard_B2ms"
  user_pool_vm_size   = "Standard_B2ms"
  

  depends_on = [module.resource_group, module.vnet]
}

module "dns" {
  source          = "git::https://github.com/nullplatform/tofu-modules.git///infrastructure/azure/dns?ref=v1.12.4"
  domain_name     = local.domain_name
  resource_group  = module.resource_group.resource_group_name
  subscription_id = var.azure_subscription_id

}

module "resource_group" {
  source              = "git::https://github.com/nullplatform/tofu-modules.git///infrastructure/azure/resource_group?ref=v1.12.4"
  resource_group_name = local.resource_group_name
  location            = var.location
  subscription_id     = var.azure_subscription_id
  tags                = {}
}

module "vnet" {
  source              = "git::https://github.com/nullplatform/tofu-modules.git///infrastructure/azure/vnet?ref=v1.12.4"
  address_space       = var.address_space
  vnet_name           = local.vnet_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  subnets_definition  = var.subnets_definition
  subscription_id     = var.azure_subscription_id
}

module "private_dns" {
  source          = "git::https://github.com/nullplatform/tofu-modules.git///infrastructure/azure/private_dns?ref=v1.17.1"
  domain_name     = local.domain_name
  resource_group  = local.resource_group_name
  subscription_id = var.azure_subscription_id
}


###############################################################################
# Agent | At least one per cluster
################################################################################
module "agent" {
  source                  = "git::https://github.com/nullplatform/tofu-modules.git//nullplatform/agent?ref=v1.12.7"
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

  depends_on = [module.aks]
}

module "base" {
  source       = "git::https://github.com/nullplatform/tofu-modules.git///nullplatform/base?ref=v1.17.1"
  np_api_key   = var.np_api_key
  nrn          = var.nrn
  k8s_provider = var.k8s_provider
  gateway_internal_enabled = true
}

module "cert_manager" {
  source                 = "git::https://github.com/nullplatform/tofu-modules.git///infrastructure/commons/cert_manager?ref=v1.17.1"
  cloud_provider         = "cloudflare"
  account_slug           = var.account_slug
  hosted_zone_name       = local.domain_name
  private_domain_name    = local.domain_name
  cloudflare_secret_name = var.cloudflare_secret_name
  cloudflare_token       = var.cloudflare_token
  cert_manager_namespace = var.cert_manager_namespace

  depends_on = [module.base, module.aks]
}

module "istio" {
  source = "git::https://github.com/nullplatform/tofu-modules.git///infrastructure/commons/istio?ref=v1.12.4"
}

module "external_dns" {
  source                 = "git::https://github.com/nullplatform/tofu-modules.git///infrastructure/commons/external_dns?ref=v1.12.7"
  dns_provider_name      = "cloudflare"
  domain                 = "nullimplementation.com"
  external_dns_namespace = "external-dns"
  extra_args             = []
  cloudflare_token       = var.cloudflare_token

  depends_on = [module.aks]
}

module "prometheus" {
  source               = "git::https://github.com/nullplatform/tofu-modules.git//nullplatform/prometheus?ref=v1.10.0"
  np_api_key           = var.np_api_key
  nrn                  = var.nrn
  install_prometheus   = var.install_prometheus
  dimensions           = var.prometheus_dimensions
  prometheus_namespace = var.prometheus_namespace

  # Temporary fix
  prometheus_url = ""
}