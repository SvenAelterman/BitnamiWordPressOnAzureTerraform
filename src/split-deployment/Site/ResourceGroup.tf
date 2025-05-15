module "app_rg" {
  source           = "Azure/avm-res-resources-resourcegroup/azurerm"
  version          = "~>0.2.1"
  enable_telemetry = var.enable_telemetry

  name     = replace(local.naming_structure, "{resourceType}", "rg")
  location = local.location
  tags     = var.tags
}
