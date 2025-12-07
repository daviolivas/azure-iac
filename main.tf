## network interface

resource "azurerm_network_interface" "vm1_nic" {
  name                = "test-machine-1-nic"
  location            = "brazilsouth"
  resource_group_name = "machines"

  ip_configuration {
    name                          = "my_nic_configuration"
    subnet_id                     = var.class_c_subnet_id
    private_ip_address_allocation = "Dynamic"
    # Adicionando o IP Público:
    public_ip_address_id          = azurerm_public_ip.virtual-machine-1-public-ip.id
  }
}

## ip

resource "azurerm_public_ip" "virtual-machine-1-public-ip" {
  name                = "test-machine-1-public-ip"
  location            = "brazilsouth"
  resource_group_name = "machines"
  allocation_method   = "Static"
  sku                 = "Basic"
}

## virtual machine

resource "azurerm_linux_virtual_machine" "virtual-machine-1" {
  name                  = "test-machine-1"
  admin_username        = "azureuser"
  admin_password        = "BanaNa12345_hello"
  location              = "brazilsouth"
  resource_group_name   = "machines"
  network_interface_ids = azurerm_network_interface.vm1_nic.id
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

## disks

resource "azurerm_managed_disk" "hdd1_lvm" {
  name                = "hdd1_lvm"
  location            = "brazilsouth"
  resource_group_name = "disks"
  storage_account_type = "Standard_HDD_LRS" # O tipo mais básico e barato
  create_option        = "Empty"
  disk_size_gb         = 10 # Defina o tamanho desejado (exemplo: 10 GB)
}

resource "azurerm_managed_disk" "hdd2_lvm" {
  name                = "hdd2_lvm"
  location            = "brazilsouth"
  resource_group_name = "disks"
  storage_account_type = "Standard_HDD_LRS" # O tipo mais básico e barato
  create_option        = "Empty"
  disk_size_gb         = 10 # Defina o tamanho desejado (exemplo: 10 GB)
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk-attach-1" {
  managed_disk_id    = azurerm_managed_disk.hdd1_lvm.id
  virtual_machine_id = azurerm_linux_virtual_machine.virtual-machine-1.id
  lun                = 1
  caching            = "None"
  write_accelerator_enabled = false
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk-attach-2" {
  managed_disk_id    = azurerm_managed_disk.hdd2_lvm.id
  virtual_machine_id = azurerm_linux_virtual_machine.virtual-machine-1.id
  lun                = 2
  caching            = "None"
  write_accelerator_enabled = false
}

## outputs

output "virtual-machine-1-public-ip-address" {
  value       = azurerm_public_ip.virtual-machine-1-public-ip.ip_address
  description = "Endereço IP público da máquina virtual"
}