data "azurerm_virtual_network" "vnet" {
  for_each            = var.azurerm_bastion_host
  name                = each.value.vnet_name
  resource_group_name = each.value.rg_name
}
data "azurerm_subnet" "subnet" {
  for_each             = var.azurerm_bastion_host
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  =each.value.rg_name
}