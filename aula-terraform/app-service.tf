resource "azurerm_linux_web_app" "appservice" {
  name                = "terraform-appservice"
  resource_group_name = azurerm_resource_group.rg-appservice-tf2.name
  location            = azurerm_resource_group.rg-appservice-tf2.location
  service_plan_id     = azurerm_service_plan.appservice_plan.id

  site_config {
    always_on = false
    application_stack {
      dotnet_version = "8.0"
    }
  }
  
  app_settings = {
    "Firebase__ProjectId" = "aula-terraform-a7143"
  }

  connection_string {
    name  = "dbconnection"
    type  = "PostgreSQL"
    value = "Server=${azurerm_postgresql_flexible_server.psqlflexibleserver2.fqdn};Port=${var.pgport};Password=${var.pgpassword};Persist Security Info=True;User Id=${var.pgadmin};Database=${azurerm_postgresql_flexible_server_database.pgdbterraform.name};Pooling=true;SslMode=Require"
  }

  public_network_access_enabled = true

  zip_deploy_file = "Confeite2.zip"

  tags = {
    "source" = "Terraform" 
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "app_vnet_integration" {
  app_service_id = azurerm_linux_web_app.appservice.id
  subnet_id      = azurerm_subnet.terraform-vn-sn-app.id
}
