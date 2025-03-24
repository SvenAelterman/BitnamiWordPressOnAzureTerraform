# Bitnami WordPress On Azure (Terraform)

A deployment of Bitnami's WordPress container image on Azure App Service. Includes Azure Database for MySQL Flexible Server.

## Azure Verified Modules

Where available, this deployment uses the [Azure Verified Modules](https://aka.ms/AVM) for Terraform.

## Quick Deployment Instructions

1. Clone the repo locally (or to Azure Cloud Shell).
1. Create a `tfvars` file.
1. Specify the required variables and any optional variables whose defaults you wish to modify.
1. Run `terraform init`.
1. Run `terraform plan`.
1. Review the planned deployment.
1. Run `terraform apply`.

## Architecture Diagram

The faint icons at the bottom should be considered for production deployments but are not implemented by this IaC.

![image](https://github.com/user-attachments/assets/ffaab0d3-257c-4eae-94be-b8a35da74e6a)

