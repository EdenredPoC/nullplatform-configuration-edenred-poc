################################################################################
# Nullplatform Configuration
################################################################################

variable "nrn" {
  description = "Nullplatform Resource Name (NRN), e.g., 'nrn:organization:xxxxx:account:xxxxxx'"
  type        = string
}

variable "np_api_key" {
  description = "Nullplatform API key (organization-level; requires roles: agent, developer, ops, secops, secrets reader)"
  type        = string
  sensitive   = true
}


################################################################################
# Container Registry Authentication
################################################################################

variable "login_server" {
  description = "Azure Container Registry login server URL"
  type        = string
}

variable "path" {
  description = "Azure Container Registry image path"
  type        = string
}

variable "username" {
  description = "Username for ACR authentication"
  type        = string
}

variable "password" {
  description = "Password for ACR authentication"
  type        = string
  sensitive   = true
}

################################################################################
# Channel Configuration
################################################################################


variable "dimensions" {
  description = "Metadata dimensions for observability or tagging"
  type        = map(string)
  default     = {}
}

variable "organization_slug" {
  description = "Name of the organization"
  type        = string
}

variable "tags_selectors" {
  description = "Map of tags used to select and filter channels and agents"
  type        = map(string)
}

variable "service_path_scheduled_task" {
  description = "Path to the service directory within the repository structure"
  type        = string
  default     = "/scheduled_task"
}

variable "override_repo_path" {
  description = "Path to the nullplatform scope repository"
  type        = string
  default     = "/root/.np/nullplatform/scopes"
}


