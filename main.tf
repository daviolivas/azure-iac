resource "azurerm_network_interface" "vm1_nic" {
  name                = "test-machine-1-nic"
  location            = "brazilsouth"
  resource_group_name = "machines"

  ip_configuration {
    name                          = "my_nic_configuration"
    subnet_id                     = var.class_c_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "virtual-machine-1" {
  name                  = "test-machine-1"
  admin_username        = "azureuser"
  admin_password        = "BanaNa12345_hello"
  location              = "brazilsouth"
  resource_group_name   = "machines"
  network_interface_ids = [azurerm_network_interface.vm1_nic.id]
  size                  = "Standard_B1ls"
  disable_password_authentication = false

  os_disk {
    name                 = "test-machine-1-Os-Disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}