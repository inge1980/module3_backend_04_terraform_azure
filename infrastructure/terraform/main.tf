terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.5.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  address_space = [
    "10.0.0.0/16"
  ]
}

resource "azurerm_subnet" "main" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name

  address_prefixes = [
    "10.0.1.0/24"
  ]
}

resource "azurerm_network_security_group" "main" {
  name                = var.network_security_group_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_network_security_rule" "ssh" {
  name      = "allow-ssh"
  priority  = 100
  direction = "Inbound"
  access    = "Allow"
  protocol  = "Tcp"

  source_port_range      = "*"
  destination_port_range = "22"

  source_address_prefix      = "*"
  destination_address_prefix = "*"

  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main.name
}

resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = azurerm_subnet.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}