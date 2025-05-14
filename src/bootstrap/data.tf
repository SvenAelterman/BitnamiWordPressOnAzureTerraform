data "http" "runner_ip" {
  url = "https://ipecho.net/plain"
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}
