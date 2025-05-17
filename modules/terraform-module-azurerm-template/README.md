# terraform-module-local-template

This is a template (boilerplate) for new [Terraform modules](https://developer.hashicorp.com/terraform/language/modules) that use the [`hashicorp/azurerm` provider](https://registry.terraform.io/providers/hashicorp/azurerm).
Copy it for creating new modules, to ensure consistent structure, naming conventions, etc.

## Usage

Example usage of the module:

```terraform
module "azurerm_template" {
  source = "./modules/terraform-module-azurerm-template"

  location = "germanywestcentral"
  tags     = { foo = "bar" }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.26 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.29.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | Virtual network address space | `string` | `"10.0.0.0/16"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment / stage to provision ('dev' or 'prod') | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location name | `string` | `"westeurope"` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Virtual network subnets | `list(string)` | <pre>[<br>  "frontend",<br>  "backend"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Copyright and license

Copyright 2024 Achim Christ, released under the [MIT license](../../LICENSE).
