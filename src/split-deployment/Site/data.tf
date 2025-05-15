data "azurerm_key_vault" "key_vault" {
  name                = local.key_vault_name
  resource_group_name = local.key_vault_resource_group_name
}

data "azurerm_service_plan" "asp" {
  name                = local.app_service_plan_name
  resource_group_name = local.app_service_plan_resource_group_name
}

data "azurerm_mysql_flexible_server" "mysql" {
  name                = local.mysql_name
  resource_group_name = local.mysql_resource_group_name
}

data "azurerm_storage_account" "storage" {
  name                = local.storage_account_name
  resource_group_name = local.storage_account_resource_group_name
}

data "azurerm_subnet" "app_subnet" {
  name                 = local.subnet_name
  virtual_network_name = local.virtual_network_name
  resource_group_name  = local.virtual_network_resource_group_name
}

data "azurerm_container_registry" "acr" {
  count = local.use_acr ? 1 : 0

  name                = local.container_registry_name
  resource_group_name = local.container_registry_resource_group_name
}
