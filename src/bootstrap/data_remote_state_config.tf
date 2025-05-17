resource "local_file" "remote_data" {
  filename = "${path.module}/../split-deployment/site/data_remote_state.tf"

  content = <<EOF
// Values from ../Foundation/backend.tf
data "terraform_remote_state" "foundation_state" {
  count   = var.use_foundation_remote_state ? 1 : 0
  backend = "azurerm"

  config = {
    resource_group_name  = "${var.resource_group_name}"
    storage_account_name = "${module.storage.name}"
    container_name       = "${split("/", module.storage.containers.tfstate.id)[12]}"
    key                  = "foundation.tfstate"
    use_azuread_auth     = true
  }
}
  EOF
}

# At the time of writing, the storage account module output does not include the container name, so we parse it from the ID.
