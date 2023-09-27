
resource "azurerm_public_ip" "publicipforlb" {
  for_each            = var.LoadBalancer
  name                = each.value.lbpipname
  location            = each.value.location
  resource_group_name = each.value.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_lb" "NginxLoadBalancer" {
  for_each            = var.LoadBalancer
  name                = each.value.lb_name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  frontend_ip_configuration {
    name                 = each.value.frondendip_name
    public_ip_address_id = azurerm_public_ip.publicipforlb[each.key].id
  }
}
resource "azurerm_lb_backend_address_pool" "BackEndAddressPool" {
  for_each        = var.LoadBalancer
  loadbalancer_id = azurerm_lb.NginxLoadBalancer[each.key].id
  name            = each.value.backendaddress_name

}
resource "azurerm_lb_backend_address_pool_address" "backendnginx01" {
  for_each=var.LoadBalancer
  name                    = each.value.backednpool_name1
  backend_address_pool_id = azurerm_lb_backend_address_pool.BackEndAddressPool[each.key].id
  virtual_network_id      = data.azurerm_virtual_network.vnet[each.key].id
  ip_address              = data.azurerm_virtual_machine.virtual_machine1[each.key].private_ip_address
}
resource "azurerm_lb_backend_address_pool_address" "backendnginx02" {
  for_each                = var.LoadBalancer
  name                    = each.value.backednpool_name2
  backend_address_pool_id = azurerm_lb_backend_address_pool.BackEndAddressPool[each.key].id
  virtual_network_id      = data.azurerm_virtual_network.vnet[each.key].id
  ip_address              = data.azurerm_virtual_machine.virtual_machine2[each.key].private_ip_address
}
resource "azurerm_lb_probe" "NginxLoadBalancer" {
  for_each        = var.LoadBalancer
  loadbalancer_id = azurerm_lb.NginxLoadBalancer[each.key].id
  name            = "http-port"
  port            = 80
}

resource "azurerm_lb_rule" "lbrule" {
  for_each                       = var.LoadBalancer
  loadbalancer_id                = azurerm_lb.NginxLoadBalancer[each.key].id
  name                           = "NginxRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = each.value.frontendip_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.BackEndAddressPool[each.key].id]
  probe_id                       = azurerm_lb_probe.NginxLoadBalancer[each.key].id
}