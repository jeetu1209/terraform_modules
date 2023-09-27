data "azurerm_key_vault" "jky" {
  # for_each            = var.virtual_machine
  name                = "jeetuvm"
  resource_group_name = "jeetu97"
}
data "azurerm_key_vault_secret" "secret1" {
  # for_each=var.virtual_machine
  name         ="username"
  key_vault_id = data.azurerm_key_vault.jky.id
}

data "azurerm_key_vault_secret" "secret2" {
  
  name         = "password"
  key_vault_id = data.azurerm_key_vault.jky.id
}
resource "azurerm_public_ip" "pip" {
  for_each=var.virtual_machine
  name                = each.value.pip_name
  resource_group_name = each.value.rg_name
  location            = each.value.location
  allocation_method   = "Static"
}
data "azurerm_subnet" "frontend_subnet" {
  for_each=var.virtual_machine
    name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.virtual_machine
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.frontend_subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[each.key].id
  }
}

resource "azurerm_windows_virtual_machine" "window_vm" {
  for_each            = var.virtual_machine
  name                = each.value.vm_name
  resource_group_name = each.value.rg_name
  location            = each.value.location
  size                = "Standard_F2"
  admin_username      = data.azurerm_key_vault_secret.secret1.value
  admin_password      = data.azurerm_key_vault_secret.secret2.value
  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "microsoftwindowsdesktop"
    offer     = "windows-10"
    sku       = "win10-21h2-ent"
    version   = "latest"
  }
}

