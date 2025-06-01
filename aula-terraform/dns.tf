resource "azurerm_dns_zone" "zona" {
  name                = "codeforgge.tech"
  resource_group_name = "recipes-api-RG"
}

resource "azurerm_dns_cname_record" "app_cname" {
  name                = "confeite"
  zone_name           = azurerm_dns_zone.zona.name
  resource_group_name = azurerm_dns_zone.zona.resource_group_name
  ttl                 = 300
  record              = azurerm_linux_web_app.appservice.default_hostname
}

resource "azurerm_app_service_custom_hostname_binding" "custom_hostname" {
  hostname            = "confeite.codeforgge.tech"
  app_service_name    = azurerm_linux_web_app.appservice.name
  resource_group_name = azurerm_linux_web_app.appservice.resource_group_name
}