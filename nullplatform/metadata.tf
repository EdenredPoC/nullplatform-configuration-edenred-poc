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
