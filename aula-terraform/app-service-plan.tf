resource "azurerm_service_plan" "appservice_plan" {
  name                = "terraform-appservice-plan"
  resource_group_name = azurerm_resource_group.rg-appservice-tf2.name
  location            = azurerm_resource_group.rg-appservice-tf2.location
  os_type             = "Linux"
  sku_name            = "B1"
}