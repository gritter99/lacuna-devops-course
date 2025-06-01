resource "azurerm_virtual_network" "terraform-vn2" {
  name                = "terraform-vn2"
  location            = azurerm_resource_group.rg-appservice-tf2.location
  resource_group_name = azurerm_resource_group.rg-appservice-tf2.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "terraform-vn-sn-db" {
  name                 = "terraform-vn-sn-db"
  resource_group_name  = azurerm_resource_group.rg-appservice-tf2.name
  virtual_network_name = azurerm_virtual_network.terraform-vn2.name
  address_prefixes     = ["10.0.2.0/24"]
  private_link_service_network_policies_enabled = true
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"

    }
  }
}

resource "azurerm_subnet" "terraform-vn-sn-app" {
  name                 = "terraform-vn-sn-app"
  resource_group_name  = azurerm_resource_group.rg-appservice-tf2.name
  virtual_network_name = azurerm_virtual_network.terraform-vn2.name
  address_prefixes     = ["10.0.1.0/24"]
  private_link_service_network_policies_enabled = false

  delegation {
  name = "appservice-delegation"
  service_delegation {
    name = "Microsoft.Web/serverFarms"
    actions = [
      "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

