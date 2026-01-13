locals {
  resource_group_name    = "rg-${var.organization_slug}-poc"
  cluster_name           = "${var.organization_slug}-poc"
  containerregistry_name = "acr${var.organization_slug}poc"
  domain_name            = "${var.organization_slug}.nullimplementation.com"
}