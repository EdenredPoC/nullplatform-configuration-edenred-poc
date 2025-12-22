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

