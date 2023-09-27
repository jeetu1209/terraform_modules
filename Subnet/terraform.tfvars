subnet = {

  "subnet1" = {
    name                 = "subnet-1"
    resource_group_name  = "jeetu97"
    virtual_network_name = "windowvnet"
    address_prefixes     = ["10.0.1.0/24"]


  },

  "subnet2" = {
    name                 = "subnet-2"
    resource_group_name  = "jeetu97"
    virtual_network_name = "windowvnet"
    address_prefixes     = ["10.0.2.0/24"]
  },

  "subnet3" = {
    name                 = "subnet-3"
    resource_group_name  = "jeetu98"
    virtual_network_name = "linuxvnet"
    address_prefixes     = ["10.1.1.0/24"]
  },

  "subnet4" = {
    name                 = "subnet-4"
    resource_group_name  = "jeetu98"
    virtual_network_name = "linuxvnet"
    address_prefixes     = ["10.1.2.0/24"]
  },
  
  "subnet5" = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "jeetu98"
    virtual_network_name = "linuxvnet"
    address_prefixes     = ["10.1.3.0/24"]
}
}
