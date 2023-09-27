data "azurerm_virtual_network" "vnetid" {
  for_each = var.vnetpeering

  name                = each.value.local_vnet-peering
  resource_group_name = each.value.local_peerig_rg
}



resource "azurerm_virtual_network_peering" "vnetpeering" {
  for_each                  = var.vnetpeering
  name                      = each.value.vnetpeering
  resource_group_name       = each.value.resource_group_name
  virtual_network_name      = each.value.virtual_network_name
  remote_virtual_network_id = data.azurerm_virtual_network.vnetid[each.key].id
}