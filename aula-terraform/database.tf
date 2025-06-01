resource "azurerm_private_dns_zone" "postgresql" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.rg-appservice-tf2.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgresql_link" {
  name                  = "postgresql-vnet-link"
  resource_group_name   = azurerm_resource_group.rg-appservice-tf2.name
  private_dns_zone_name = azurerm_private_dns_zone.postgresql.name
  virtual_network_id    = azurerm_virtual_network.terraform-vn2.id
  registration_enabled  = false
}

resource "random_string" "unique" {
  length  = 3
  upper   = false
  numeric = true
  special = false
}

resource "azurerm_postgresql_flexible_server" "psqlflexibleserver2" {
  name                   = "psqlflexibleserver${random_string.unique.result}"
  resource_group_name    = azurerm_resource_group.rg-appservice-tf2.name
  location               = azurerm_resource_group.rg-appservice-tf2.location
  version                = "16"
  administrator_login    = var.pgadmin
  administrator_password = var.pgpassword
  storage_mb             = 32768
  sku_name               = "B_Standard_B1ms"
  lifecycle {
    ignore_changes = ["zone"]
  }
  delegated_subnet_id    = azurerm_subnet.terraform-vn-sn-db.id
  private_dns_zone_id    = azurerm_private_dns_zone.postgresql.id
  depends_on             = [ azurerm_private_dns_zone_virtual_network_link.postgresql_link ]
}

resource "azurerm_postgresql_flexible_server_database" "pgdbterraform" {
  name      = "Confeite"
  server_id = azurerm_postgresql_flexible_server.psqlflexibleserver2.id
  collation = "en_US.utf8"
  charset   = "utf8"

}
