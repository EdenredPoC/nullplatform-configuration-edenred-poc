#Policy to check that an app if a app is PCI. If not, the policy is approved.
resource "nullplatform_approval_policy" "PCI" {
  nrn  = var.nrn
  name = "PCI"
  conditions = jsonencode({
    "application.metadata.metadata_application.PCI" = "No"
  })
}

#Policy to check that new code has 80% of code coverage or more
resource "nullplatform_approval_policy" "coverage" {
  nrn    = var.nrn
  name   = "Code Coverage"
  conditions = jsonencode({
    "build.metadata.coverage.code.coverage" = { "$gte": 80 }
  })
}

#Policy to check that new code don´t have critical security vulnerabilities
resource "nullplatform_approval_policy" "security" {
  nrn    = var.nrn
  name   = "Security"
  conditions = jsonencode({
    "build.metadata.security.security.vulnerabities.critical" = { "$eq": 0 }
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

resource "nullplatform_approval_action_policy_association" "coverage" {
  approval_action_id  = nullplatform_approval_action.deployment_create.id
  approval_policy_id  = nullplatform_approval_policy.coverage.id
}

resource "nullplatform_approval_action_policy_association" "security" {
  approval_action_id  = nullplatform_approval_action.deployment_create.id
  approval_policy_id  = nullplatform_approval_policy.security.id
}

resource "nullplatform_approval_action_policy_association" "PCI" {
  approval_action_id = nullplatform_approval_action.deployment_create.id
  approval_policy_id = nullplatform_approval_policy.PCI.id
}