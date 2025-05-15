output "key_vault_name" {
  value = module.key_vault.name
}

output "key_vault_resource_group_name" {
  value = module.shared_app_rg.name
}

output "app_service_plan_name" {
  value = module.asp.name
}

output "app_service_plan_resource_group_name" {
  value = module.asp.resource.resource_group_name
}

output "mysql_name" {
  value = module.mysql.resource.name
}

output "mysql_resource_group_name" {
  value = module.mysql.resource.resource_group_name
}
output "storage_account_name" {
  value = module.storage.name
}

output "storage_account_resource_group_name" {
  value = module.storage.resource.resource_group_name
}

output "virtual_network_name" {
  value = module.vnet.name
}

output "virtual_network_resource_group_name" {
  value = module.network_rg.name
}

output "subnet_name" {
  value = module.vnet.subnets["AppServiceSubnet"].name
}

output "custom_image_name" {
  value = null_resource.docker_image.triggers.image_name
}

output "custom_image_tag" {
  value = null_resource.docker_image.triggers.image_tag
}

output "container_registry_name" {
  value = module.container_registry.name
}

output "container_registry_resource_group_name" {
  value = module.container_registry.resource.resource_group_name
}

output "subscription_id" {
  value = data.azurerm_client_config.current.subscription_id
}

output "location" {
  value = var.location
}
