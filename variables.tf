variable "env" {
  type        = string
  description = "Environment / stage to provision ('dev' or 'prod')"

  validation {
    condition     = contains(["dev", "prod"], var.env)
    error_message = "Environment must be either 'dev' or 'prod'"
  }
}
