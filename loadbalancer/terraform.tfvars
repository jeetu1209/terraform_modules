LoadBalancer = {

  lb1 = {
    lbpipname       = "local-pip"
    location         = "central india"
    rg_name          = "jeetu98"
    lb_name          = "nignexlb1"
    frontendip_name  = "nginexpublicfrondend"
    bkpool_name      = "backendpool"
    vnet_name        = "linuxvnet"
    virtual_machine1 = "linuxvm1"
    virtual_machine2  = "linuxvm2"
    frondendip_name  = "frondenpublicip"
    backednpool_name1 = "backednpoolname1"
  backednpool_name2 = "backednpoolname2"
  backendaddress_name="backendaddresspool"
}
}