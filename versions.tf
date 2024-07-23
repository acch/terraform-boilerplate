terraform {
  required_version = ">= 1.6"

  required_providers {
    /*
    the root module does not require any providers directly.
    its sole purpose is to reference child modules, which declare their required providers.
    terraform will find all providers required by any child modules.
    */
  }
}
