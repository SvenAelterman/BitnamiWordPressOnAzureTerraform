# WordPress site deployment as part of the split deployment model

## Terraform State for different sites

In order to separate the Terraform state for different sites, you will use [Terraform workspaces](https://developer.hashicorp.com/terraform/cli/workspaces). Each workspace will have its own state file.

After running the bootstrap deployment, you'll find a backend.tf file in this folder that does not specify a key. If you don't want to run the bootstrap, you can create a backend.tf file manually.

> Note: this approach will not work without remote state. A possible alternative is to use workspaces.

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "wptfstate-demo-rg-cnc-01"
    storage_account_name = "wptfstatedemostcnc01"
    container_name       = "tfstate"
    
    use_azuread_auth     = true
  }
}
```

For each site you wish to deploy, create an HCL file that simply specifies the key and nothing else. See below more more details.

### First site

Assume your first WordPress site is for the *math* department. Create a *backend_math.hcl* file (the name is entirely up to you, but you might want to organize them where the filename matches the value you'll use for the `site_name` variable):

```hcl
# File: backend_math.hcl

key = "math.tfstate"
```

Create a variables file, if desired:

```hcl
# File: vars.math.tfvars

site_name = "math"
# Specify more variables here
```

For consistency, you should not use the Terraform *default* workspace. Each site will get a named workspace.

`terraform workspace new math`

When running `terraform init`, you will then specify the HCL file as backend configuration:

`terraform init -backend-config="backend_math.hcl"`

This will create the backend configuration by merging the backend.tf file (which is the same for each site you'll deploy) and the .hcl file you specified.

When running `terraform [plan|apply]`, you will specify the variables file:

`terraform [plan|apply] -var-file="vars.math.tfvars"`

### Site n

When you create another site, you will create a new HCL file containing backend config (in addition to presumably creating a different tfvars file too):

```hcl
# File: backend_site2.hcl

key = "site2.tfstate"
```

When you run `terraform init` next, you'll use this command:

`terraform init -backend-config="backend_site2.hcl" -reconfigure`

Then, you can create the next site like this:

`terraform [plan|apply] -var-file="vars.site2.tfvars"`

### Switching between sites

If you need to update the infrastructure for an existing site, run:

`terraform workspace select math`

## File organization

If you'll have many sites, it might be preferable to create a directory structure to store the variables and backend config files for each site.
