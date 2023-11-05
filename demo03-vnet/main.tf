# Create vnet
resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  address_space       = [var.address_space]
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
}

# subnets
resource "azurerm_subnet" "windows_subnet" {
  name                 = var.subnet1_name
  resource_group_name  = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [cidrsubnet(var.address_space, 8, 5)] # 8 bits on top of addrespace and last number is the actual subnet 10.0.5.0/24 in this example
}

resource "azurerm_subnet" "linux_subnet" {
  name                 = var.subnet2_name
  resource_group_name  = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [cidrsubnet(var.address_space, 8, 4)] # 8 bits on top of addrespace and last number is the actual subnet 10.0.4.0/24 in this example
}

resource "azurerm_network_security_group" "windows" {
  name                = "windows-NSG"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  security_rule {
    name                       = "Allow_RDP_for_everyone"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "linux" {
  name                = "linux-NSG"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  security_rule {
    name                       = "Allow_SSH_for_everyone"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "linux" {
  subnet_id                 = azurerm_subnet.linux_subnet.id
  network_security_group_id = azurerm_network_security_group.linux.id
}


resource "azurerm_subnet_network_security_group_association" "windows" {
  subnet_id                 = azurerm_subnet.windows_subnet.id
  network_security_group_id = azurerm_network_security_group.windows.id
}