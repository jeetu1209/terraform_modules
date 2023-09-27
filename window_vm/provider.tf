terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.71.0"
    }
  }


  backend "azurerm" {
    resource_group_name  = "storagerg"
    storage_account_name = "storageluck1"
    container_name       = "statefil21"
    key                  = "windowvm/prod.terraform.tfstate"
  }
}





provider "azurerm" {
  features {

  }
}
