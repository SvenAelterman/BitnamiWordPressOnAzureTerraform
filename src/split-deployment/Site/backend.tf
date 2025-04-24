terraform {
  backend "azurerm" {
    resource_group_name  = ""
    storage_account_name = ""
    container_name       = "tfstate"

    use_azuread_auth = true
  }
}
