terraform{
 required_providers{
  azurerm={
    source = "hashicorp/azurerm"
    version = "3.94.0"
  }
 } 
}

provider "azurerm" {
  skip_provider_registration = true
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  
}