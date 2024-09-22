# Terraform-Boilerplate

[![GitHub Issues](https://img.shields.io/github/issues/acch/terraform-boilerplate.svg)](https://github.com/acch/terraform-boilerplate/issues)
[![GitHub Stars](https://img.shields.io/github/stars/acch/terraform-boilerplate.svg?label=github%20%E2%98%85)](https://github.com/acch/terraform-boilerplate/)
[![License](https://img.shields.io/github/license/acch/terraform-boilerplate.svg)](LICENSE)

[Terraform](https://www.terraform.io/) is an Infrastructure as Code (IaC) tool.
It uses declarative configuration for managing infrastructure resources with [providers](https://developer.hashicorp.com/terraform/language/providers).
The configuration files in this repository can act as a template for your own Terraform projects, in order to get you started quickly.

## Using this repository

Simply download (clone) the repository and start modifying files according to your needs.

```
git clone https://github.com/acch/terraform-boilerplate.git myTerraformProject/
```

Ideally, you'll want to use [Git](https://git-scm.com/) to manage your Terraform configuration files.
For that purpose simply [fork](https://help.github.com/articles/fork-a-repo/) this repository into your own Git repository before cloning and customizing it.
Alternatively, create your own repository [from the template](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-from-a-template).
Git will allow you to version and roll-back changes with ease.

Specifically, you'll want to customize the following files:

- Enable Providers (Azure, AWS, Google Cloud):

  - Enable features in `Makefile`:

    ```make
    ENABLE_AWS		:= FALSE
    ENABLE_AZURE	:= FALSE
    ENABLE_GCP		:= FALSE
    ```

  - Define appropriate variables (subscriptions, etc.) in `Makefile`:

    ```make
    AZ_SUBSCRIPTION := my-azure-subscription
    ```

- Optionally, enable [Remote State](https://developer.hashicorp.com/terraform/language/state/remote) via HCP Terraform:

  - Create [organization](https://app.terraform.io/app/organizations/new) and project in [HCP Terraform](https://app.terraform.io/app)

    - Change organization `Default Execution Mode` to `Local`

  - Add HCP organization and project name to `backend.tf`:

    ```terraform
    terraform {
      cloud {
        organization = "my-org"

        workspaces {
          project = "my-project"
          tags = ["my-tag"]
        }
      }
    }
    ```

## Using Terraform

All [Terraform CLI](https://developer.hashicorp.com/terraform/cli) commands, along with their required parameters, are stored in a file called the `Makefile`.
Hence, you can execute all tasks related to this project using [GNU Make](https://www.gnu.org/software/make/):

```shell
# print all targets
make

# login to required services (HCP, Azure, etc.)
make login

# run 'terraform init'
# prepare your working directory for other commands
make init

# run 'terraform plan' in 'dev' environment (stage)
# show changes required by the current configuration
ENV=dev make plan

# run 'terraform apply' in 'dev' environment (stage)
# create or update infrastructure
ENV=dev make apply

# run 'terraform destroy' in 'dev' environment (stage)
# destroy previously-created infrastructure
ENV=dev make destroy
```

> Important:
> Resources are deployed into two distinct environments (stages): `dev` and `prod`.
> You select the environment (stage) for a given command by defining the `ENV` environment variable appropiately (i.e. `ENV=dev` or `ENV=prod`).

## Configuration

Configuration settings are defined in [YAML](https://yaml.org/) files in the `config/` subdirectory.
Settings stored in `config/*.yml` are always loaded.
Futhermore, depending on the environment (stage) being deployed, configuration from _either_ `config/dev/*.yml` _or_ `config/prod/*.yml` is loaded.

```shell
config/
├── deployment.yml
├── dev
│   └── dev.yml
└── prod
    └── prod.yml
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_local_template"></a> [local\_template](#module\_local\_template) | ./modules/terraform-module-local-template | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Environment / stage to provision ('dev' or 'prod') | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Copyright and license

Copyright 2024 Achim Christ, released under the [MIT license](LICENSE).
