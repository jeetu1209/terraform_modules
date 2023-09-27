data "azurerm_virtual_network" "vnet" {
  for_each            = var.LoadBalancer
  name                = each.value.vnet_name
  resource_group_name = each.value.rg_name
}

data "azurerm_virtual_machine" "virtual_machine1" {
  for_each            = var.LoadBalancer
  name                = each.value.virtual_machine1
  resource_group_name = each.value.rg_name
}
data "azurerm_virtual_machine" "virtual_machine2" {
  for_each            = var.LoadBalancer
  name                = each.value.virtual_machine2
  resource_group_name = each.value.rg_name
}