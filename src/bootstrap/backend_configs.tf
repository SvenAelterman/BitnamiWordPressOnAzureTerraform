resource "local_file" "all_in_one_backend_configs" {
  for_each = local.backend_config_folders

  filename = "${each.value}/backend.tf"

  content = <<EOF
terraform {
  backend "azurerm" {
    resource_group_name  = "${var.resource_group_name}"
    storage_account_name = "${module.storage.name}"
    container_name       = "${split("/", module.storage.containers.tfstate.id)[12]}"
    key                  = "${each.key}.tfstate"
    use_azuread_auth     = true
  }
}
  EOF
}

# At the time of writing, the storage account module output does not include the container name, so we parse it from the ID.
