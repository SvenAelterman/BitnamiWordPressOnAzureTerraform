output "key_vault_id" {
  value = module.key_vault.resource_id
}

output "key_vault_name" {
  value = module.key_vault.name
}

output "storage_account_id" {
  value = module.storage.resource_id
}

output "app_subnet_id" {
  value = module.vnet.subnets["AppServiceSubnet"].resource_id
}
