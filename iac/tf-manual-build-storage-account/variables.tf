# Set values for Locals and Variables - using naming convention defined by Microsoft [ResourceType]-[Workload/Application]-[Environment]-[AzureRegion]-[Instance] 
# https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming
#

#
# Locals
#

locals {
  
  # Common tags to be assigned to all resources
  common_tags = { 
    Environment  = var.environment 
    Department   = "mfodemo"
  }
}

#
# Variables
#

variable "subscription_id" {
  type         = string
  description  = "Enter subscription_id for Azure Subscription to resource storage account"
}

# [ResourceType]-[Workload/Application]-[Environment]-[AzureRegion]-[Instance]

variable "azurerm_storage_container_resource_name" {
  default       = "terraformfiles"
  description   = "resource_name"
}

variable "workload" {
  default       = "terraformstate"
  description   = "Naming Convention Workload"
}

variable "environment" {
  default       = "iac"
  description   = "Naming Convention Environment"
}

variable "azure_region" {
  default       = "uksouth"
  description   = "Naming Convention Azure Region"
}

variable "instance" {
  default       = "001"
  description   = "Naming Convention Instance"
}