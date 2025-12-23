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

#Finops Metadata
resource "nullplatform_metadata_specification" "finops" {
  name        = "Costo de Metadata"
  description = "Costo de Metadata"
  nrn         = var.nrn
  entity      = "application"
  metadata    = "finops"

  schema = jsonencode({
    "uiSchema": {
            "type": "VerticalLayout",
            "elements": [
                {
                    "type": "HorizontalLayout",
                    "elements": [
                        {
                            "type": "Control",
                            "scope": "#/properties/costo_computo",
                            "label": "Costo de Computo",
                            "options": {
                                "style": {
                                    "fontSize": "1.5rem",
                                    "color": "success.main"
                                },
                                "icon": "mdi:currency-usd"
                            }
                        },
                        {
                            "type": "Control",
                            "scope": "#/properties/costo_total_actual",
                            "label": "Costo Total Actual",
                            "options": {
                                "style": {
                                    "fontSize": "1.5rem",
                                    "color": "success.main"
                                },
                                "icon": "mdi:currency-usd"
                            }
                        }
                    ]
                },
                {
                    "type": "HorizontalLayout",
                    "elements": [
                        {
                            "type": "Control",
                            "scope": "#/properties/costo_services",
                            "label": "Costo de Services",
                            "options": {
                                "style": {
                                    "fontSize": "1.5rem",
                                    "color": "success.main"
                                },
                                "icon": "mdi:currency-usd"
                            }
                        },
                        {
                            "type": "Control",
                            "scope": "#/properties/presupuesto_asignado",
                            "label": "Presupuesto Asignado Total",
                            "options": {
                                "style": {
                                    "fontSize": "1.5rem",
                                    "color": "warning.main"
                                },
                                "icon": "mdi:currency-usd"
                            }
                        }
                    ]
                },
                {
                    "type": "Control",
                    "scope": "#/properties/pci",
                    "label": "PCI"
                },
                {
                    "type": "Control",
                    "scope": "#/properties/owner",
                    "label": "Responsable"
                },
                {
                    "type": "Control",
                    "scope": "#/properties/slo",
                    "label": "SLO"
                }
            ]
        },
        "properties": {
            "compute_cost": {
                "description": "Application compute cost",
                "type": "integer",
                "visibleOn": [
                    "read"
                ]
            },
            "services_cost": {
                "description": "Application services cost",
                "minimum": 0,
                "type": "integer",
                "visibleOn": [
                    "read"
                ]
            },
            "current total cost": {
                "description": "Current total cost",
                "minimum": 0,
                "type": "integer",
                "visibleOn": [
                    "read"
                ]
            },
            "owner": {
                "description": "Persona responsable de la aplicacion",
                "enum": [
                    "Federico Ferrari",
                    "Silvia Accasuso",
                    "Juan Dominguez"
                ],
                "type": "string"
            },
            "pci": {
                "description": "Is this application PCI?",
                "enum": [
                    "Yes",
                    "No"
                ],
                "type": "string"
            },
            "budget assigned": {
                "description": "Application budget assigned",
                "minimum": 0,
                "type": "integer",
                "visibleOn": [
                    "read"
                ]
            },
            "slo": {
                "description": "What kind of SLO does this application have?",
                "enum": [
                    "Critical",
                    "High",
                    "Medium",
                    "Low"
                ],
                "type": "string"
            }
        },
        "required": [],
        "type": "object"
  })
}
