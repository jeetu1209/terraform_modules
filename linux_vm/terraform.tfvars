rgname       = "jeetu98"
location     = "central india"
username      = "usernamejeetuvm"
userpassword = "passwordjeetuvm"

virtual_machine = {

  vm01 = {
    subnet  = "subnet-3"
    vnet    = "linuxvnet"
    pip     = "jeetupip1"
    nicname = "jeetunic1"
    vmname  = "linuxvm01"

  },

  vm02 = {
    subnet  = "subnet-4"
    vnet    = "linuxvnet"
    pip     = "jeetupip2"
    nicname = "jeetunic2"
    vmname  = "linuxvm02"
  }

}
