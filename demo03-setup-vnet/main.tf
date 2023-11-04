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

# subnets
resource "azurerm_subnet" "windows_subnet" {
  name                 = var.subnet1_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [cidrsubnet(var.address_space, 8, 1)] # 8 bits on top of addrespace and last number is the actual subnet 10.0.1.0/24 in this example
}

resource "azurerm_subnet" "linux_subnet" {
  name                 = var.subnet2_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [cidrsubnet(var.address_space, 8, 2)] # 8 bits on top of addrespace and last number is the actual subnet 10.0.2.0/24 in this example
}



# Create subnets
# resource "azurerm_subnet" "public" {
#   name                 = "${var.name}-public-subnet"
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.this.name
#   address_prefixes     = [cidrsubnet(var.address_space, 8, 1)]
# }