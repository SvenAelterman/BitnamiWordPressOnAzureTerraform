variable "naming_convention" {
  type        = string
  description = "The naming convention to be used for all resources in this deployment."
  default     = "{workloadName}-{environment}-{resourceType}-{region}-{instance}"
}

variable "environment" {
  type        = string
  description = "The environment name for the resources."
  default     = "demo"
}

variable "instance" {
  type        = number
  description = "The instance number for the deployment."
  default     = 1
}

variable "enable_telemetry" {
  type        = bool
  description = "Enable telemetry for the Azure Verified Modules."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources."
  default     = {}
}

variable "secret_expiration_date_seed" {
  type        = string
  description = "The seed value for the secret expiration date. Set it to today's YYYY-MM-DDT00:00:00Z."
}

// TODO: Opt-in variable to create role assignments for the current user

variable "site_name" {
  type        = string
  description = "The name of the WordPress site, which is also used for creating Azure resource names."
}
