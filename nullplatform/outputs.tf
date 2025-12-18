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


output "service_specification_id_scheduled_task" {
  description = "ID of the service specification created by scope_definition for scheduled task"
  value       = module.scope_definition_scheduled_task.service_specification_id
}

output "service_slug_scheduled_task" {
  description = "Slug of the service created by scope_definition for scheduled task"
  value       = module.scope_definition_scheduled_task.service_slug
}
