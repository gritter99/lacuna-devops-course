terraform {
  backend "azurerm" {
    resource_group_name  = "exampleresourcestest"
    storage_account_name = "storaccrittertest"
    container_name       = "tf-state"
    key                 = "terraform.tfstate"
  }
}