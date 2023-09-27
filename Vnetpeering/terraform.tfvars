vnetpeering = {

  "vnet1" = {
    vnetpeering          = "peering1-2"
    resource_group_name  = "jeetu97"
    virtual_network_name = "windowvnet"
    local_vnet-peering   = "linuxvnet"
    local_peerig_rg      = "jeetu98"

  },


  "vnet2" = {
    vnetpeering          = "peering2-1"
    resource_group_name  = "jeetu98"
    virtual_network_name = "linuxvnet"
    local_vnet-peering   = "windowvnet"
    local_peerig_rg      = "jeetu97"
  }

}
