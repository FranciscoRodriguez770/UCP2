# Creamos las tres máquinas virtuales
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine

resource "azurerm_linux_virtual_machine" "VMWorkers" {
    
    name                = "${var.workers[count.index]}"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = var.vm_size_workers
    count               = length(var.workers)
    admin_username      = "adminUsername"
    network_interface_ids = [azurerm_network_interface.myNic1[count.index + 1].id]
    disable_password_authentication = true

    admin_ssh_key {
        username   = "adminUsername"
        public_key = file("C:/Users/frodrigue53m/.ssh/k8s.pub")
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stAccount.primary_blob_endpoint
    }

    tags = {
        environment = "CP2"
    }
}

resource "azurerm_linux_virtual_machine" "VMMaster" {
    
    name                = "${var.master}"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = var.vm_size_master
    admin_username      = "adminUsername"
    network_interface_ids = [ azurerm_network_interface.myNic1[0].id ]
    disable_password_authentication = true

    admin_ssh_key {
        username   = "adminUsername"
        public_key = file("C:/Users/frodrigue53m/.ssh/k8s.pub")
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stAccount.primary_blob_endpoint
    }

    tags = {
        environment = "CP2"
    }
}

