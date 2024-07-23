terraform {
  required_version = ">= 1.6"

  required_providers {
    random = {
      # https://registry.terraform.io/providers/hashicorp/random
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
    local = {
      # https://registry.terraform.io/providers/hashicorp/local
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}
