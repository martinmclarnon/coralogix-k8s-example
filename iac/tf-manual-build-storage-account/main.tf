# Configure the Azure provider

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

# using naming convention defined by Microsoft:
# [ResourceType]-[Workload/Application]-[Environment]-[AzureRegion]

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.workload}-${var.environment}-${var.azure_region}"
  location = var.azure_region
  tags     = local.common_tags
}

# using naming convention defined by Microsoft:
# [ResourceType]-[Workload/Application]-[Environment]-[AzureRegion]-[Instance]

resource "azurerm_storage_account" "sa" {
  name                     = "st${var.workload}${local.common_tags.Department}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags                     = local.common_tags
  depends_on               = [azurerm_resource_group.rg]
}

# using naming convention defined by Microsoft:
# [ResourceType]-[Workload/Application]-[Environment]-[AzureRegion]-[Instance]

resource "azurerm_storage_container" "sc" {
  name                  = "terraformfiles"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
  depends_on          = [azurerm_storage_account.sa]
}