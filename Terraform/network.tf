# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network

resource "azurerm_virtual_network" "myNet" {
    name                = "kubernetesnet"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    
    tags = {
        environment = "CP2"
    }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet

resource "azurerm_subnet" "mySubnet" {
    name                 = "terraformsubnet"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.myNet.name
    address_prefixes     = ["10.0.1.0/24"]
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

resource "azurerm_network_interface" "myNic1" {
    name                = "nic-M${count.index + 1}"
    count               = length(var.workers) + 1
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    ip_configuration {
        name                          = "ipconf-M${count.index + 1}"
        subnet_id                     = azurerm_subnet.mySubnet.id
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.0.1.${count.index + 10}"
        public_ip_address_id          = azurerm_public_ip.myPublicIp1[count.index].id
    }
    tags = {
        environment = "CP2"
    }
}

resource "azurerm_public_ip" "myPublicIp1" {
  name                = "vmip-M${count.index}"
  count               = length(var.workers) + 1
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
    tags = {
        environment = "CP2"
    }
}
