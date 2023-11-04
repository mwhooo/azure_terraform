resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = var.resource_group_name
  tags     = var.rg_tags
}

# Create vnet
resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  address_space       = [var.address_space]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnets
# resource "azurerm_subnet" "public" {
#   name                 = "${var.name}-public-subnet"
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.this.name
#   address_prefixes     = [cidrsubnet(var.address_space, 8, 1)]
# }

# resource "azurerm_subnet" "private" {
#   name                 = "${var.name}-private-subnet"
#   resource_group_name  = azurerm_resource_group.this.name
#   virtual_network_name = azurerm_virtual_network.this.name
#   address_prefixes     = [cidrsubnet(var.address_space, 8, 10)]
# }
