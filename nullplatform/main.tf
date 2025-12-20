###############################################################################
# K8s Scope Definition | Set this at organization level
###############################################################################
module "scope_definition" {
  source       = "git::https://github.com/nullplatform/tofu-modules.git//nullplatform/scope_definition?ref=v1.12.4"
  nrn          = var.nrn
  np_api_key   = var.np_api_key
  service_path = var.service_path
}

module "scope_definition_scheduled_task" {
  source       = "git::https://github.com/nullplatform/tofu-modules.git//nullplatform/scope_definition?ref=v1.12.7"
  nrn          = var.nrn
  np_api_key   = var.np_api_key
  service_path = var.service_path_scheduled_task
  service_spec_name = "Scheduled Task"
  service_spec_description = "Allows you to deploy periodic jobs in Kubernetes"
  action_spec_names = [
    "create-scope",
    "delete-scope",
    "start-initial",
    "start-blue-green",
    "finalize-blue-green",
    "rollback-deployment",
    "delete-deployment",
    "trigger"
]
}


module "dimensions" {
  source       = "git::https://github.com/nullplatform/tofu-modules.git///nullplatform/dimensions?ref=v1.12.4"
  nrn          = var.nrn
  np_api_key   = var.np_api_key
  environments = var.environments
}

#Metadata Application
resource "nullplatform_metadata_specification" "metadata_application" {
  name        = "Metadata Application"
  description = "Add metadata to application"
  nrn         = var.nrn
  entity      = "application"
  metadata    = "metadata_application"

  schema = jsonencode({
    type = "object"
    properties = {
      "APPLICATION OWNER": {
        "description": "Name of Application Owner",
        "type": "string"
      },
      "PCI": {
        "description": "Is it a PCI application?",
        "type": "string",
        "enum": ["Yes", "No"]
      },
      "SLO": {
        "description": "Application SLO Criteria",
        "type": "string",
        "enum": ["Low", "Medium", "Critical" , "High"]
      }
    }
    "required": [
      "APPLICATION OWNER",
      "PCI"
    ],
    additionalProperties = false
  }) 
}

#Policies Configuration
resource "nullplatform_approval_policy" "PCI" {
  nrn    = var.nrn
  name   = "PCI"
  conditions = jsonencode({
    "application.metadata.metadata_application.PCI" = "No"
  })
}


resource "nullplatform_approval_action" "deployment_create" {
  nrn = var.nrn
  entity = "deployment"
  action = "deployment:create"

  dimensions = {
    environment = "production"
  }

  on_policy_success = "approve"
  on_policy_fail = "manual"

  lifecycle {
    ignore_changes = [policies]
  }
}

resource "nullplatform_approval_action_policy_association" "PCI" {
  approval_action_id  = nullplatform_approval_action.deployment_create.id
  approval_policy_id  = nullplatform_approval_policy.PCI.id
}



module "service_definition_endpoint_exposer" {
  source       = "git::https://github.com/nullplatform/tofu-modules.git//services/endpoint-exposer?ref=feature/endpoint-exposer"
  nrn          = var.nrn
}


