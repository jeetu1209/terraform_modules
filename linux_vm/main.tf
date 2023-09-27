data "azurerm_key_vault" "jeetuvm-keyvault" {
  # for_each            = var.virtual_machine
  name                = "jeetuvmkeyvault1"
  resource_group_name = var.rgname
}
data "azurerm_key_vault_secret" "secret1" {
  # for_each=var.virtual_machine
  name=var.username
  key_vault_id = data.azurerm_key_vault.jeetuvm-keyvault.id
}
data "azurerm_key_vault_secret" "secret2" {

  # for_each=var.virtual_machine
  name=var.userpassword 
  key_vault_id = data.azurerm_key_vault.jeetuvm-keyvault.id
}

data "azurerm_subnet" "subnet" {
  for_each=var.virtual_machine  
  name                 = each.value.subnet
  virtual_network_name = each.value.vnet
  resource_group_name  = var.rgname
}

resource "azurerm_public_ip" "public_ip" {
  for_each            = var.virtual_machine
  name                = each.value.pip
  resource_group_name = var.rgname
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.virtual_machine
  name                = each.value.nicname
  location            = var.location
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[each.key].id
  }
}

resource "azurerm_linux_virtual_machine" "virtual_machine" {

  for_each            = var.virtual_machine
  name                = each.value.vmname
  resource_group_name = var.rgname
  location            = var.location
  size                = "Standard_F2"
  admin_username      = data.azurerm_key_vault_secret.secret1.value
  admin_password      = data.azurerm_key_vault_secret.secret2.value
  network_interface_ids =[
    azurerm_network_interface.nic[each.key].id,
    ]
disable_password_authentication=false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}


