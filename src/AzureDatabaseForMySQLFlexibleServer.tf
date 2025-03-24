module "db_rg" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "~>0.2.1"

  name     = replace(local.naming_structure, "{resourceType}", "rg-data")
  location = var.location
  tags     = var.tags

  enable_telemetry = var.enable_telemetry
}

module "mysql" {
  source           = "Azure/avm-res-dbformysql-flexibleserver/azurerm"
  version          = "~>0.1.1"
  enable_telemetry = var.enable_telemetry

  name                = replace(local.naming_structure, "{resourceType}", "mysql")
  location            = module.db_rg.resource.location
  resource_group_name = module.db_rg.name
  tags                = var.tags

  sku_name      = "GP_Standard_D2ds_v4"
  zone          = "1"
  mysql_version = "8.0.21"

  high_availability = {
    mode                      = var.enable_high_availability ? "ZoneRedundant" : "SameZone"
    standby_availability_zone = var.enable_high_availability ? "2" : "1"
  }

  delegated_subnet_id = module.vnet.subnets["MySQLSubnet"].resource_id
  private_dns_zone_id = module.mysql_private_dns_zone.resource_id

  administrator_login    = "dbadmin"
  administrator_password = random_password.mysql_random_password.result

  databases = {
    "WordPress" = {
      name      = local.wp_database_name
      charset   = "utf8"
      collation = "utf8_general_ci"
    }
  }

  // TODO: Enable TLS?
  server_configuration = {
    require_secure_transport_off = {
      name  = "require_secure_transport"
      value = "OFF"
    }
  }
}

resource "random_password" "mysql_random_password" {
  length      = 20
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
}

