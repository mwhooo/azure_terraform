data "azurerm_resource_group" "rg" {
    name = "azure-tf-demo"
}

data "azurerm_subnet" "windows_subnet" {
    name = "Windows_Subnet"
    resource_group_name = data.azurerm_resource_group.rg.name
    virtual_network_name = "demo-vnet"
}

resource "azurerm_storage_account" "demo_storage" {
  name                     = "demostorage2411"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  public_network_access_enabled = false

  tags = {
    environment = "demo"
  }
}

resource "azurerm_private_endpoint" "storage_private_endpoint" {
  name                = "${azurerm_storage_account.demo_storage.name}-ple"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = data.azurerm_subnet.windows_subnet.id

  private_service_connection {
    name                           = "${azurerm_storage_account.demo_storage.name}-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.demo_storage.id
    subresource_names              = ["blob"]
  }
  depends_on = [ azurerm_storage_account.demo_storage ]
}
