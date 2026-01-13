locals {
  resource_group_name    = "rg-${var.organization_slug}-poc"
  cluster_name           = "gti-ctp-gwc1-s-aks"
  domain_name            = "${var.organization_slug}.nullimplementation.com"
}