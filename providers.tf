terraform {
  required_version = ">=1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.9.0"
    }
    random = {
      source = "hashicorp/random"
      version = ">=3.0.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = ">=4.0.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = false
    }
  }
}
