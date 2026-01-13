################################################################################
# Azure Provider Configuration
################################################################################

variable "azure_subscription_id" {
  description = "Azure subscription ID where resources will be deployed"
  type        = string
}

variable "azure_client_id" {
  description = "Azure service principal client ID for authentication"
  type        = string
}

variable "azure_client_secret" {
  description = "Azure service principal client secret for authentication"
  type        = string
  sensitive   = true
}

variable "azure_tenant_id" {
  description = "Azure tenant ID for authentication"
  type        = string
}

################################################################################
# Resource Group Configuration
################################################################################

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
}


################################################################################
# Nullplatform Configuration
################################################################################

variable "nrn" {
  description = "Nullplatform Resource Name - Unique identifier for Nullplatform resources"
  type        = string
}

variable "np_api_key" {
  description = "API key for authenticating with the Nullplatform API"
  type        = string
  sensitive   = true
}

variable "k8s_provider" {
  description = "Cloud provider identifier for Nullplatform (e.g., aks)"
  type        = string
  default     = "aks"
}

variable "cloud_provider" {
  description = "Cloud provider identifier for Nullplatform (e.g., aks)"
  type        = string
  default     = "azure"
}

variable "account_slug" {
  description = "Nullplatform account slug identifier"
  type        = string
}

################################################################################
# Agent Configuration
################################################################################

variable "image_tag" {
  description = "Docker image tag for the Nullplatform agent"
  type        = string
  default     = "latest"
}

variable "tags_selectors" {
  description = "Map of tags used to select and filter channels and agents"
  type        = map(string)
}

variable "private_hosted_zone_rg" {
  description = "Resource group name for the private hosted zone"
  type        = string
  default     = null
}

variable "private_gateway_name" {
  description = "Name of the private gateway for internal traffic"
  type        = string
}

variable "public_gateway_name" {
  description = "Name of the public gateway for external traffic"
  type        = string
}

################################################################################
# Cert Manager Configuration
################################################################################

variable "cert_manager_namespace" {
  description = "Kubernetes namespace for cert-manager"
  type        = string
  default     = "cert-manager"
}

variable "cloudflare_enabled" {
  description = "Enable Cloudflare as DNS provider for cert-manager"
  type        = bool
  default     = false
}

variable "cloudflare_secret_name" {
  description = "Name of the Kubernetes secret containing Cloudflare credentials"
  type        = string
  default     = null
}

variable "cloudflare_token" {
  description = "Cloudflare API token for DNS validation"
  type        = string
  sensitive   = true
  default     = null
}

variable "organization_slug" {
  description = "Name of the organization"
  type        = string
}

variable "dns_type" {
  description = "Type of DNS provider (e.g., 'azure', 'aws', 'gcp', 'external_dns')"
  type        = string
}

################################################################################
# Agent Istio Templates Configuration
################################################################################

variable "image_pull_secrets" {
  description = "Image pull secrets for the agent"
  type        = string
  default     = ""
}

variable "use_account_slug" {
  description = "Whether to use account slug in the agent configuration"
  type        = bool
  default     = false
}

variable "service_template" {
  description = "Path to the service template for Istio"
  type        = string
  default     = "/root/.np/nullplatform/scopes/k8s/deployment/templates/istio/service.yaml.tpl"
}

variable "initial_ingress_path" {
  description = "Path to the initial ingress template for Istio"
  type        = string
  default     = "/root/.np/nullplatform/scopes/k8s/deployment/templates/istio/initial-httproute.yaml.tpl"
}

variable "blue_green_ingress_path" {
  description = "Path to the blue-green ingress template for Istio"
  type        = string
  default     = "/root/.np/nullplatform/scopes/k8s/deployment/templates/istio/blue-green-httproute.yaml.tpl"
}

variable "prometheus_dimensions" {
  description = "Optional map of Prometheus dimension labels to apply to metrics and resources."
  type        = map(string)
  default     = {}
}
variable "prometheus_namespace" {
  description = "Namespace where Prometheus will be installed."
  type        = string
  default     = "nullplatform-monitoring"
}

variable "install_prometheus" {
  description = "Whether Prometheus should be installed alongside nullplatform."
  type        = bool
  default     = true
}