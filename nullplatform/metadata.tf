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
      "APPLICATION OWNER" : {
        "description" : "Name of Application Owner",
        "type" : "string"
      },
      "PCI" : {
        "description" : "Is it a PCI application?",
        "type" : "string",
        "enum" : ["Yes", "No"]
      },
      "SLO" : {
        "description" : "Application SLO Criteria",
        "type" : "string",
        "enum" : ["Low", "Medium", "Critical", "High"]
      }
    }
    "required" : [
      "APPLICATION OWNER",
      "PCI"
    ],
    additionalProperties = false
  })
}

#Finops Example
resource "nullplatform_metadata_specification" "coverage" {
  name        = "Coverage Schema"
  description = "Schema for code coverage configuration"
  nrn         = var.nrn
  entity      = "build"
  metadata    = "coverage"

  schema = jsonencode({
    type        = "object"
    title       = "Code Coverage Results"
    description = "Schema for code coverage configuration"
    properties = {
      code = {
        type = "object"
        properties = {
          coverage = {
            type        = "number"
            minimum     = 0
            maximum     = 100
            description = "Percentage of code coverage"
          }
          lines = {
            type        = "integer"
            minimum     = 0
            description = "Total amount of code lines"
          }
        }
        required             = ["coverage"]
        additionalProperties = false
      }
    }
    required             = ["code"]
    additionalProperties = false
  })
}

resource "nullplatform_metadata_specification" "security" {
  name        = "Security Schema"
  description = "Schema for security vulnerability configuration"
  nrn         = var.nrn
  entity      = "build"
  metadata    = "security"

  schema = jsonencode({
    type        = "object"
    title       = "Security Vulnerability Results"
    description = "Schema for security vulnerability configuration"
    properties = {
      security = {
        type = "object"
        properties = {
          vulnerabilities = {
            type = "object"
            properties = {
              high = {
                type        = "integer"
                minimum     = 0
                description = "Number of high severity vulnerabilities"
              }
              critical = {
                type        = "integer"
                minimum     = 0
                description = "Number of critical severity vulnerabilities"
              }
            }
            required             = ["high", "critical"]
            additionalProperties = false
          }
        }
        required             = ["vulnerabilities"]
        additionalProperties = false
      }
    }
    required             = ["security"]
    additionalProperties = false
  })
}

#Finops Metadata
resource "nullplatform_metadata_specification" "finops" {
  name        = "Finops"
  description = "Details of Application costs"
  nrn         = var.nrn
  entity      = "application"
  metadata    = "finops"

  schema = jsonencode({
    "visibleOn" : ["read"],
    "type" : "object",
    "properties" : {
      "compute_cost" : {
        "description" : "Application compute cost",
        "type" : "integer"
      },
      "services_cost" : {
        "description" : "Application services cost",
        "minimum" : 0,
        "type" : "integer"
      },
      "current_total_cost" : {
        "description" : "Current total cost",
        "minimum" : 0,
        "type" : "integer"
      },
      "budget_assigned" : {
        "description" : "Application budget assigned",
        "minimum" : 0,
        "type" : "integer"
      }
    },
    "required" : []
  })
}
