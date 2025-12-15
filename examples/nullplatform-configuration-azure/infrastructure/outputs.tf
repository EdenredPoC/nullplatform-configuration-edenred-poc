################################################################################
# Outputs - Infrastructure
################################################################################

output "resource_group_name" {
  description = "Name of the Azure resource group"
  value       = module.resource_group.resource_group_name
}

output "resource_group_location" {
  description = "Location of the Azure resource group"
  value       = module.resource_group.resource_group_location
}

