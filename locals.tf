locals {
  # load config settings from YAML files in 'config/' directory
  config_path    = "${path.root}/config"
  config_pattern = "*.yml"
  common_config  = [for f in fileset(local.config_path, local.config_pattern) : yamldecode(file("${local.config_path}/${f}"))]
  stage_config   = [for f in fileset("${local.config_path}/${var.env}", local.config_pattern) : yamldecode(file("${local.config_path}/${var.env}/${f}"))]
  config         = merge(concat(local.common_config, local.stage_config)...)

  # common tags
  tags = merge(
    local.config.tags, {
      Environment = local.config.environment
      Stage       = local.config.stage
      Source      = "Terraform"
  })
}
