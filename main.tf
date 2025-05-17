# modules/terraform-module-local-template
module "local_template" {
  count  = 0 # disabled
  source = "./modules/terraform-module-local-template"

  filename = local.config.filename

  environment = local.config.environment
}

# modules/terraform-module-azurerm-template
module "azurerm_template" {
  count  = 1 # enabled
  source = "./modules/terraform-module-azurerm-template"

  location = local.config.location

  environment = local.config.environment
  tags        = local.tags
}
