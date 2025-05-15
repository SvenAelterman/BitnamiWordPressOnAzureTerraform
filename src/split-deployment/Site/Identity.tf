module "id" {
  source           = "Azure/avm-res-managedidentity-userassignedidentity/azurerm"
  version          = "~>0.3.3"
  enable_telemetry = var.enable_telemetry

  name                = replace(local.naming_structure, "{resourceType}", "id")
  location            = module.app_rg.resource.location
  resource_group_name = module.app_rg.name
  tags                = var.tags
}

// HACK: Wait 30 seconds after the user-assigned managed identity is created
// before assigning it the Key Vault Secrets User role on the shared Key Vault.
resource "time_sleep" "wait_30_seconds" {
  create_duration = "30s"
  depends_on      = [module.id]
}

locals {
  role_assignments_for_key_vault_scope = { key_vault = {
    scope = data.azurerm_key_vault.key_vault.id
    role_assignments = {
      kvsu = {
        role_definition                  = "kvsu"
        user_assigned_managed_identities = ["id"]
        principal_type                   = "ServicePrincipal"
      }
    }
    }
  }

  // Only create a role assignment for the ACR if there is an ACR specified
  role_assignments_for_acr_scope = local.use_acr ? { acr = {
    scope = data.azurerm_container_registry.acr[0].id
    role_assignments = {
      acrpull = {
        role_definition                  = "acrpull"
        user_assigned_managed_identities = ["id"]
        principal_type                   = "ServicePrincipal"
      }
    }
    }
  } : null

  // Merge the role assignments for Key Vault and ACR scopes
  role_assignments_for_scopes = merge(local.role_assignments_for_key_vault_scope, local.role_assignments_for_acr_scope)
}

module "id_key_vault_role_assignment" {
  source           = "Azure/avm-res-authorization-roleassignment/azurerm"
  version          = "~>0.2.0"
  enable_telemetry = var.enable_telemetry

  role_assignments_for_scopes = local.role_assignments_for_scopes

  user_assigned_managed_identities_by_principal_id = { id = module.id.resource.principal_id }
  role_definitions = {
    kvsu = {
      name = "Key Vault Secrets User"
    }
    acrpull = {
      name = "AcrPull"
    }
  }

  depends_on = [module.id, time_sleep.wait_30_seconds]
}
