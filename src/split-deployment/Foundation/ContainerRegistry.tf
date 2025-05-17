module "container_registry" {
  source           = "Azure/avm-res-containerregistry-registry/azurerm"
  version          = "~> 0.4.0"
  enable_telemetry = var.enable_telemetry

  name                = replace(replace(local.naming_structure, "{resourceType}", "kv"), "-", "")
  location            = module.shared_app_rg.resource.location
  resource_group_name = module.shared_app_rg.name
  tags                = var.tags

  // TODO: Set network restrictions on the ACR
}
