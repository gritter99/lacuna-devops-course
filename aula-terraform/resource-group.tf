resource "azurerm_resource_group" "rg-appservice-tf2" {
  name     = "terraform-appservice-rg2"
  location = "Brazil South"
  tags = {
    environment = "Test",
    source      = "Terraform"
  }
}