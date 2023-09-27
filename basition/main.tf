resource "azurerm_public_ip" "pip" {
  for_each            = var.azurerm_bastion_host
  name                = each.value.pip_name
  location            = each.value.location
  resource_group_name = each.value.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "azurerm_bastion_host" {
  for_each            = var.azurerm_bastion_host
  name                = each.value.bastion_name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.subnet[each.key].id
    public_ip_address_id = azurerm_public_ip.pip[each.key].id
  }
}
