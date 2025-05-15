// Variables processing based on using Foundation remote state or not
locals {
  subscription_id                        = var.use_foundation_remote_state ? data.terraform_remote_state.foundation_state[0].outputs.subscription_id : var.subscription_id
  location                               = var.use_foundation_remote_state ? data.terraform_remote_state.foundation_state[0].outputs.location : var.location
  key_vault_name                         = var.use_foundation_remote_state ? data.terraform_remote_state.foundation_state[0].outputs.key_vault_name : var.key_vault_name
  key_vault_resource_group_name          = var.use_foundation_remote_state ? data.terraform_remote_state.foundation_state[0].outputs.key_vault_resource_group_name : var.key_vault_resource_group_name
  app_service_plan_name                  = var.use_foundation_remote_state ? data.terraform_remote_state.foundation_state[0].outputs.app_service_plan_name : var.app_service_plan_name
  app_service_plan_resource_group_name   = var.use_foundation_remote_state ? data.terraform_remote_state.foundation_state[0].outputs.app_service_plan_resource_group_name : var.app_service_plan_resource_group_name
  mysql_name                             = var.use_foundation_remote_state ? data.terraform_remote_state.foundation_state[0].outputs.mysql_name : var.mysql_name
  mysql_resource_group_name              = var.use_foundation_remote_state ? data.terraform_remote_state.foundation_state[0].outputs.mysql_resource_group_name : var.mysql_resource_group_name
  storage_account_name                   = var.use_foundation_remote_state ? data.terraform_remote_state.foundation_state[0].outputs.storage_account_name : var.storage_account_name
  storage_account_resource_group_name    = var.use_foundation_remote_state ? data.terraform_remote_state.foundation_state[0].outputs.storage_account_resource_group_name : var.storage_account_resource_group_name
  virtual_network_name                   = var.use_foundation_remote_state ? data.terraform_remote_state.foundation_state[0].outputs.virtual_network_name : var.virtual_network_name
  virtual_network_resource_group_name    = var.use_foundation_remote_state ? data.terraform_remote_state.foundation_state[0].outputs.virtual_network_resource_group_name : var.virtual_network_resource_group_name
  subnet_name                            = var.use_foundation_remote_state ? data.terraform_remote_state.foundation_state[0].outputs.subnet_name : var.subnet_name
  image_name                             = var.use_foundation_remote_state ? data.terraform_remote_state.foundation_state[0].outputs.custom_image_name : var.wordpress_container_image_name
  image_tag                              = var.use_foundation_remote_state ? data.terraform_remote_state.foundation_state[0].outputs.custom_image_tag : var.wordpress_container_image_tag
  container_registry_name                = var.use_foundation_remote_state ? data.terraform_remote_state.foundation_state[0].outputs.container_registry_name : var.container_registry_name
  container_registry_resource_group_name = var.use_foundation_remote_state ? data.terraform_remote_state.foundation_state[0].outputs.container_registry_resource_group_name : var.container_registry_resource_group_name
}

locals {
  instance_formatted = format("%02d", var.instance)

  naming_structure = replace(replace(replace(replace(var.naming_convention, "{workloadName}", var.site_name), "{environment}", var.environment), "{region}", local.short_locations[local.location]), "{instance}", local.instance_formatted)

  // This is in the Foundation deployment
  dbadmin_password_kv_secret_name = "dbadmin-password"

  wpadmin_password_kv_secret_name = "${var.site_name}-wpadmin-password"

  wp_database_name = "${var.site_name}_wordpress_db"

  // Add 1 year based on calendar dates, not days in the year, etc.
  start_year  = tonumber(formatdate("YYYY", var.secret_expiration_date_seed))
  start_month = formatdate("MM", var.secret_expiration_date_seed)
  start_day   = formatdate("DD", var.secret_expiration_date_seed)
  next_year   = local.start_year + 1
  next_date   = "${local.next_year}-${local.start_month}-${local.start_day}"

  secret_expiration_date = "${local.next_date}T00:00:00Z"

  wp_share_name = "${var.site_name}-wordpress"

  use_acr = local.container_registry_name != "" && local.container_registry_resource_group_name != ""

  container_registry_url = local.use_acr ? "https://${data.azurerm_container_registry.acr[0].login_server}" : var.wordpress_registry_url
}

locals {
  short_locations = {
    "canadacentral" = "cnc"
    "centralus"     = "cus"
    "eastus"        = "eus"
    "eastus2"       = "eus2"
  }
}
