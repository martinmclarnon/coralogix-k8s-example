# Set providers and resources


terraform {
  required_version = ">=1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}


provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.workload}-${var.environment}-${var.azure_region}"
  location = var.azure_region
  tags     = local.common_tags
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = local.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = local.cluster_name

  default_node_pool {
    name                = "system"
    node_count          = var.system_node_count
    vm_size             = "Standard_B2ms"
    type                = "VirtualMachineScaleSets"
  }

  identity {
    type            = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "message_queue" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  max_count             = 2
  min_count             = 1
  mode                  = "User"
  name                  = "messagequeue"
  orchestrator_version  = var.kubernetes_version
  os_disk_size_gb       = 128
  os_type               = "Linux"
  vm_size               = "Standard_B2ms"
  priority              = "Regular"
  node_labels = {
    "nodepool-type" = "user"
    "environment"   = var.environment
    "nodepoolos"    = "linux"
    "type"          = "message-queue"
  }
  tags = {
    "nodepool-type" = "user"
    "environment"   = var.environment
    "nodepoolos"    = "linux"
    "type"          = "message-queue"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "api" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  max_count             = 2
  min_count             = 1
  mode                  = "User"
  name                  = "api"
  orchestrator_version  = var.kubernetes_version
  os_disk_size_gb       = 128
  os_type               = "Linux"
  vm_size               = "Standard_B2ms"
  priority              = "Regular"
  node_labels = {
    "nodepool-type" = "user"
    "environment"   = var.environment
    "nodepoolos"    = "linux"
    "type"          = "api"
  }
  tags = {
    "nodepool-type" = "user"
    "environment"   = var.environment
    "nodepoolos"    = "linux"
    "type"          = "api"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "db" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  max_count             = 2
  min_count             = 1
  mode                  = "User"
  name                  = "db"
  orchestrator_version  = var.kubernetes_version
  os_disk_size_gb       = 128
  os_type               = "Linux"
  vm_size               = "Standard_B2ms"
  priority              = "Regular"
  node_labels = {
    "nodepool-type" = "user"
    "environment"   = var.environment
    "nodepoolos"    = "linux"
    "type"          = "db"
  }
  tags = {
    "nodepool-type" = "user"
    "environment"   = var.environment
    "nodepoolos"    = "linux"
    "type"          = "db"
  }
}

resource "azurerm_container_registry" "acr" {
  name                     = local.container_registry_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  sku                      = "Standard"
  admin_enabled            = false
}
