# Bitnami WordPress On Azure (Terraform)

A deployment of Bitnami's WordPress container image on Azure App Service. Includes Azure Database for MySQL Flexible Server.

## Azure Verified Modules

Where available, this deployment uses the [Azure Verified Modules](https://aka.ms/AVM) for Terraform.

## Quick Deployment Instructions (All-in-One deployment)

This deployment will create fewer resources and create a single WordPress site on a single App Service Plan.

1. Clone the repo locally in a folder of your choice (or to Azure Cloud Shell).

    `git clone <repo-url>`
1. Switch to the /src/all-in-one folder.

    `cd ./src/all-in-one`
1. Fill out the information necessary for the backend Azure blob storage for Terraform state in the backend.tf file.
1. Create a `tfvars` file.
1. Specify the required variables and any optional variables whose defaults you wish to modify.
1. Run `terraform init`.
1. Run `terraform plan`.
1. Review the planned deployment.
1. Run `terraform apply`.

### Architecture Diagram

The faint icons at the bottom should be considered for production deployments but are not implemented by this IaC.

![image](https://github.com/user-attachments/assets/ffaab0d3-257c-4eae-94be-b8a35da74e6a)

## Split deployment

A more sophisticated deployment that supports hosting multiple WordPress sites on a single App Service Plan is also provided.

Refer to the [split deployment README](./src/split-deployment/README.md) for more details.

## Trivy support

To check for misconfigurations in the Terraform using [Trivy from Aqua Security](https://www.aquasec.com/products/trivy/), run `trivy fs .` in the root of the repo.
