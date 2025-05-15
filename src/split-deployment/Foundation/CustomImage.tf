# Builds a custom WordPress image for use in Azure App Service based on the Bitnami WordPress image.
# Using a null resource with an AZ CLI command so we don't have to take a dependency on Docker nor on the third-party Docker provider.
# Ref: https://github.com/karlospn/how-to-push-a-container-image-into-acr-using-terraform/blob/main/src/using_null_resource_with_az_cli/main.tf

resource "null_resource" "docker_image" {
  triggers = {
    image_name         = var.custom_image_name
    image_tag          = var.custom_image_tag
    registry_name      = module.container_registry.resource.name
    dockerfile_path    = "${path.cwd}/../../custom-image/Dockerfile"
    dockerfile_context = "${path.cwd}/../../custom-image"
    dir_sha1           = sha1(join("", [for f in fileset(path.cwd, "../../custom-image/*") : filesha1(f)]))
  }

  provisioner "local-exec" {
    command     = "az account set --subscription ${data.azurerm_client_config.current.subscription_id} && az acr build -t ${self.triggers.image_name}:${self.triggers.image_tag} -r ${self.triggers.registry_name} -f ${self.triggers.dockerfile_path} ${self.triggers.dockerfile_context}"
    interpreter = ["cmd", "/c"]
  }

  depends_on = [module.container_registry]
}
