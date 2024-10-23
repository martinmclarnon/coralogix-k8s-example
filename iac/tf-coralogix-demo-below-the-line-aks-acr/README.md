# Infrastructure as Code Pipeline #

Resource Group: 'rg-terraformstate-iac-uksouth' is generated from applying the Terraform Scripts in the 
folder "tf-manual-build-storage-account" through the terraform cli with the subscription_id for Azure Subscription 
you want this rg to be created in.

By running './iac/tf-below-the-line-aks-acr/iac.yml' via an Azure Pipeline, Terraform will script the resources necessary
to deploy the demo platform to an AKS cluster via images pushed to an ACR.