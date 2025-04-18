variable "address_space" {
  type        = string
  description = "Virtual network address space"
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrnetmask(var.address_space))
    error_message = "Address space must be valid IPv4 CIDR block"
  }
}

variable "environment" {
  type        = string
  description = "Environment / stage to provision ('dev' or 'prod')"

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Environment must be either 'dev' or 'prod'"
  }
}

variable "location" {
  type        = string
  description = "Azure location name"
  default     = "westeurope"
}

variable "tags" {
  type        = map(string)
  description = "Tags to add to resources"
  default     = {}
}
