resource "azurerm_resource_group" "rg_name" {
    for_each =var.rg
  name     = each.key
  location = each.value.location
}