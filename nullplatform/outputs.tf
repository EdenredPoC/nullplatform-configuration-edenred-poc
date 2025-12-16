################################################################################
# Outputs - Nullplatform
################################################################################

output "service_specification_id" {
  description = "ID of the service specification created by scope_definition"
  value       = module.scope_definition.service_specification_id
}

output "service_slug" {
  description = "Slug of the service created by scope_definition"
  value       = module.scope_definition.service_slug
}
