variable "subscription_id" {
  type        = string
  description = "The Azure subscription ID where the resources will be deployed."
  default     = ""

  validation {
    condition     = length(var.subscription_id) == 0 || can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.subscription_id))
    error_message = "The subscription ID must be a valid GUID."
  }
  validation {
    condition     = length(var.subscription_id) > 0 || var.use_foundation_remote_state
    error_message = "The subscription ID must be specified when not using the Foundation deployment's remote state."
  }
}

variable "location" {
  type        = string
  description = "The Azure region where the resources will be deployed."
  default     = ""

  validation {
    condition     = length(var.location) > 0 || var.use_foundation_remote_state
    error_message = "The location must be specified when not using the Foundation deployment's remote state."
  }
}

variable "key_vault_name" {
  type        = string
  description = "The name of the Key Vault to create for storing secrets."
  default     = ""

  validation {
    condition     = length(var.key_vault_name) > 0 || var.use_foundation_remote_state
    error_message = "The Key Vault name must be specified when not using the Foundation deployment's remote state."
  }
}

variable "key_vault_resource_group_name" {
  type        = string
  description = "The name of the resource group where the Key Vault was created."
  default     = ""

  validation {
    condition     = length(var.key_vault_resource_group_name) > 0 || var.use_foundation_remote_state
    error_message = "The Key Vault resource group name must be specified when not using the Foundation deployment's remote state."
  }
}

variable "app_service_plan_name" {
  type        = string
  description = "The name of the App Service Plan to use for the WordPress site."
  default     = ""

  validation {
    condition     = length(var.app_service_plan_name) > 0 || var.use_foundation_remote_state
    error_message = "The App Service Plan name must be specified when not using the Foundation deployment's remote state."
  }
}

variable "app_service_plan_resource_group_name" {
  type        = string
  description = "The name of the resource group where the App Service Plan was created."
  default     = ""

  validation {
    condition     = length(var.app_service_plan_resource_group_name) > 0 || var.use_foundation_remote_state
    error_message = "The App Service Plan resource group name must be specified when not using the Foundation deployment's remote state."
  }
}

variable "mysql_name" {
  type        = string
  description = "The name of the MySQL Flexible Server to use for the WordPress site."
  default     = ""

  validation {
    condition     = length(var.mysql_name) > 0 || var.use_foundation_remote_state
    error_message = "The MySQL Flexible Server name must be specified when not using the Foundation deployment's remote state."
  }
}

variable "mysql_resource_group_name" {
  type        = string
  description = "The name of the resource group where the MySQL Flexible Server was created."
  default     = ""

  validation {
    condition     = length(var.mysql_resource_group_name) > 0 || var.use_foundation_remote_state
    error_message = "The MySQL Flexible Server resource group name must be specified when not using the Foundation deployment's remote state."
  }
}

variable "storage_account_name" {
  type        = string
  description = "The name of the Storage Account to use for the WordPress site."
  default     = ""

  validation {
    condition     = length(var.storage_account_name) > 0 || var.use_foundation_remote_state
    error_message = "The Storage Account name must be specified when not using the Foundation deployment's remote state."
  }
}

variable "storage_account_resource_group_name" {
  type        = string
  description = "The name of the resource group where the Storage Account was created."
  default     = ""

  validation {
    condition     = length(var.storage_account_resource_group_name) > 0 || var.use_foundation_remote_state
    error_message = "The Storage Account resource group name must be specified when not using the Foundation deployment's remote state."
  }
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the Virtual Network"
  default     = ""

  validation {
    condition     = length(var.virtual_network_name) > 0 || var.use_foundation_remote_state
    error_message = "The Virtual Network name must be specified when not using the Foundation deployment's remote state."
  }
}

variable "virtual_network_resource_group_name" {
  type        = string
  description = "The name of the resource group containing the Virtual Network"
  default     = ""

  validation {
    condition     = length(var.virtual_network_resource_group_name) > 0 || var.use_foundation_remote_state
    error_message = "The Virtual Network resource group name must be specified when not using the Foundation deployment's remote state."
  }
}

variable "subnet_name" {
  type        = string
  description = "The name of the Subnet"
  default     = ""

  validation {
    condition     = length(var.subnet_name) > 0 || var.use_foundation_remote_state
    error_message = "The Virtual Network subnet name must be specified when not using the Foundation deployment's remote state."
  }
}

variable "wordpress_container_image_name" {
  type        = string
  description = "The name of the WordPress container image to use."
  default     = "bitnami/wordpress"
}

variable "wordpress_container_image_tag" {
  type        = string
  description = "The tag of the WordPress container image to use."
  default     = "6.7.2"
}

variable "wordpress_registry_url" {
  type        = string
  description = "The URL of the container registry where the WordPress image is hosted. This will only be used if there is no Azure Container Registry specified using the container_registry_name and container_registry_resource_group_name variables."
  default     = "https://index.docker.io"
}

variable "container_registry_name" {
  type        = string
  description = "The name of the Azure Container Registry to use for the WordPress image. If not specified, will attempt to use Docker Hub."
  default     = ""
}

variable "container_registry_resource_group_name" {
  type        = string
  description = "The name of the resource group where the Azure Container Registry was created. If not specified, will attempt to use Docker Hub."
  default     = ""
}

variable "use_foundation_remote_state" {
  type        = bool
  description = "Whether to use the foundation remote state for referencing shared resources."
  default     = true
}
