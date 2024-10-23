# Set values for Locals and Variables -
# using naming convention defined by Microsoft
# [ResourceType]-[Workload/Application]-[Environment]-[AzureRegion]-[Instance]
# https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming
#


#
# Locals
#

locals {

  # Common tags to be assigned to all resources
  common_tags = {
    Environment  = var.environment
    Department   = "below-the-line"
  }

  container_registry_name = "crcoralogixmfobelowtheline"
  cluster_name = "coralogixmfo"
}

#
# Variables
#
variable "kubernetes_version" {
  default       = "1.30.0"
  description = "Kubernetes version"
}
variable "system_node_count" {
  default       = 1
  description = "Number of AKS worker nodes"
}

variable "workload" {
  default       = "coralogix-mfo"
  description   = "Naming Convention Workload"
}

variable "environment" {
  default       = "demo"
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