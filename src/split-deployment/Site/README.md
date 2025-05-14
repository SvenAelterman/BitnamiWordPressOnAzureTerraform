# WordPress site deployment as part of the split deployment model

## Terraform State for different sites

In order to separate the Terraform state for different sites, you will use [Terraform workspaces](https://developer.hashicorp.com/terraform/cli/workspaces). Each workspace will have its own state file.

After running the bootstrap deployment, you'll find a backend.tf file in this folder. If you don't want to run the bootstrap, you can create a backend.tf file manually.

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "wptfstate-demo-rg-cnc-01"
    storage_account_name = "wptfstatedemostcnc01"
    container_name       = "tfstate"
    key                  = "site.tfstate"
    use_azuread_auth     = true
  }
}
```

### First site

Assume your first WordPress site is for the *math* department.

Create a variables file, if desired. The name is entirely up to you, but you might want to organize them where the filename matches the value you'll use for the `site_name` variable:

```hcl
# File: vars.math.tfvars

site_name = "math"
# ...
# Specify more variables here
```

For consistency, you should not use the Terraform *default* workspace. Each site will get a named workspace.

`terraform workspace new math`

Run `terraform init`. This will create the backend configuration.

When running `terraform [plan|apply]`, you will specify the variables file:

`terraform [plan|apply] -var-file="vars.math.tfvars"`

This will create a state file with a name like `site.tfstateenv:math

### Site n

When you create another site, you will create a new HCL file containing backend config (in addition to presumably creating a different tfvars file too):

Create a new workspace:

`terraform workspace new site2`

Then, you can create the next site like this:

`terraform [plan|apply] -var-file="vars.site2.tfvars"`

### Switching between sites

If you need to update the infrastructure for an existing site, run:

`terraform workspace select math`

## File organization

If you'll have many sites, it might be preferable to create a directory structure to store the variables and backend config files for each site.
