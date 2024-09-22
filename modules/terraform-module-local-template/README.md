# terraform-module-local-template

This is a template (boilerplate) for new [Terraform modules](https://developer.hashicorp.com/terraform/language/modules) that use the [`hashicorp/local` provider](https://registry.terraform.io/providers/hashicorp/local).
Copy it for creating new modules, to ensure consistent structure, naming conventions, etc.

## Usage

Example usage of the module:

```terraform
module "local_template" {
  source = "./modules/terraform-module-local-template"

  filename = "foo"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.5 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | ~> 2.5 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.foo](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [random_pet.content](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_filename"></a> [filename](#input\_filename) | Name of the output file. | `string` | n/a | yes |
| <a name="input_lines"></a> [lines](#input\_lines) | The number of lines to write to the output file. Defaults to 5. | `number` | `5` | no |
| <a name="input_words"></a> [words](#input\_words) | The number of words (in each line) to write to the output file. Defaults to 2. | `number` | `2` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Copyright and license

Copyright 2024 Achim Christ, released under the [MIT license](../../LICENSE).
