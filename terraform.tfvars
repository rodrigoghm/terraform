rg_name = "rg-exercise-terraform"
rg_location = "eastus2"
rg_group = 5
rg_tags_diplomado = "diplomado-usach-devops"
rg_tags_owner = "group-nro-5"
rg_tags_environment = "Test"

pip_name = "public-ip-exercise"
pip_allocation_method = "Static"

vnet_name = "my-vnet"
vnet_address_space = ["12.0.0.0/16"]

subnet_name = "internal"
subnet_address_prefixes = ["12.0.0.0/20"]

ni_name = "networkinterface-exercise"
ni_ipc_name = "internal"
ni_ipc_private_ip_address_allocation = "Dynamic"

acr_name = "myACR"
acr_sku = "Basic"
acr_admin_enabled = true

aks_name = "aks-exercise"
aks_dns_prefix = "aks1"
aks_kubernetes_version = "1.24.3"
aks_rbac_enabled = true
aks_np_name = "default"
aks_np_node_count = 1
aks_np_max_pods = 80
aks_np_vm_size = "Standard_D2_v2"
aks_np_eas = true
aks_np_max_count = 3
aks_np_min_count = 1
aks_sp_client_id = "----"
aks_sp_client_secret = "---"
aks_np_network_plugin = "azure"
aks_np_network_policy = "azure"

np_name = "adicional"
np_tag_label = "adicional"

vm_name = "vm-jenkins"
vm_size = "Standard_B1s"
vm_osdisk_caching = "ReadWrite"
vm_osdisk_storage_account_type = "Standard_LRS"
vm_sir_publisher = "Canonical"
vm_sir_offer =  "UbuntuServer"
vm_sir_sku = "16.04-LTS"
vm_sir_version = "latest"
vm_computer_name = "svr-jenkins"
vm_admin_username = "group5"
vm_admin_password = "Diplomado$ec2Gr0up5" 
vm_disable_password_authentication = false
