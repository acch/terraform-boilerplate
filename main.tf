# terraform-module-local-template
module "local_template" {
  source = "./modules/terraform-module-local-template"

  filename = local.config.filename
}
