resource "azurerm_resource_group" "rg-exercise" {
    name = var.rg_name
    location = var.rg_location

    tags = {
        "Grupo" = var.rg_group
        "Environment" = var.rg_tags_environment
    }
}

resource "azurerm_public_ip" "pip-exercise" {
    name     = var.pip_name
    resource_group_name = azurerm_resource_group.rg-exercise.name
    location = azurerm_resource_group.rg-exercise.location
    allocation_method = var.pip_allocation_method
    tags = {
      "diplomado" = var.rg_tags_diplomado
      "owner" = var.rg_tags_owner
    }
}

resource "azurerm_virtual_network" "vnet-exercise" {
  name = var.vnet_name
  address_space = var.vnet_address_space
  location = azurerm_resource_group.rg-exercise.location
  resource_group_name = azurerm_resource_group.rg-exercise.name
}

resource "azurerm_subnet" "subnet-exercise" {
    name = var.subnet_name
    resource_group_name = azurerm_resource_group.rg-exercise.name
    virtual_network_name = azurerm_virtual_network.vnet-exercise.name
    address_prefixes = var.subnet_address_prefixes
}

resource "azurerm_network_interface" "netinterface-exercise" {
    name = var.ni_name
    location = azurerm_resource_group.rg-exercise.location
    resource_group_name = azurerm_resource_group.rg-exercise.name
    ip_configuration {
      name = var.ni_ipc_name
      subnet_id = azurerm_subnet.subnet-exercise.id
      private_ip_address_allocation = var.ni_ipc_private_ip_address_allocation
      public_ip_address_id = azurerm_public_ip.pip-exercise.id
    }
}

resource "azurerm_container_registry" "acr-exercise" {
    name = var.acr_name
    resource_group_name = azurerm_resource_group.rg-exercise.name
    location = azurerm_resource_group.rg-exercise.location
    sku = var.acr_sku
    admin_enabled = var.acr_admin_enabled
}

resource "azurerm_kubernetes_cluster" "aks-exercise" {
  name = var.aks_name
  location = azurerm_resource_group.rg-exercise.location
  resource_group_name = azurerm_resource_group.rg-exercise.name
  dns_prefix = var.aks_dns_prefix
  kubernetes_version = var.aks_kubernetes_version
  role_based_access_control_enabled = var.aks_rbac_enabled

  default_node_pool {
    name = var.aks_np_name
    node_count = var.aks_np_node_count
    vm_size = var.aks_np_vm_size
    vnet_subnet_id = azurerm_subnet.subnet-exercise.id
    enable_auto_scaling = var.aks_np_eas
    min_count = var.aks_np_min_count
    max_count = var.aks_np_max_count
    max_pods = var.aks_np_max_pods
  }

  service_principal {
    client_id = var.aks_sp_client_id
    client_secret = var.aks_sp_client_secret
  }

  network_profile {
    network_plugin = var.aks_np_network_plugin
    network_policy = var.aks_np_network_policy
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "np-internal-exercise" {
  name = var.np_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks-exercise.id
  vm_size = var.aks_np_vm_size
  node_count = var.aks_np_node_count
  max_pods = var.aks_np_max_pods

  tags = {
    "Environment" = var.rg_tags_environment
    "label" = var.np_tag_label
  }
}

resource "azurerm_linux_virtual_machine" "vm-jenkins" {
    name = var.vm_name
    resource_group_name = azurerm_resource_group.rg-exercise.name
    location = azurerm_resource_group.rg-exercise.location
    size = var.vm_size
    network_interface_ids = [azurerm_network_interface.netinterface-exercise.id ]
    computer_name = var.vm_computer_name
    admin_username = var.vm_admin_username
    admin_password = var.vm_admin_password
    disable_password_authentication = var.vm_disable_password_authentication

    os_disk {
        caching = var.vm_osdisk_caching
        storage_account_type = var.vm_osdisk_storage_account_type
    }

    source_image_reference {
      publisher = var.vm_sir_publisher
      offer = var.vm_sir_offer
      sku = var.vm_sir_sku
      version = var.vm_sir_version
    }
}

