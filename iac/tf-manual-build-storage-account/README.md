# tf-manual-build-storage-account #

In order to run Terraform Scripts to create Infrastructure as Code within an Azure Pipeline, the agent running the 
Terraform Scripts needs a Storage Account to write to. When Terraform runs the commands; 'init', 'plan' and 'apply' it 
does so against files stored in a storage account. The Terraform code in this folder needs to be executed manually 
before the pipeline yaml (./iac/tf-below-the-line-aks-acr/iac.yml) to create the IaC for the Cluster 
resources.

### Infrastructure-as-Code ###

[Terraform](https://www.terraform.io) is used to create the environment the Azure Pipelines will use to manage further 
Terraform scripts.

First login to the Azure Portal

```console
az login
```
```console
$ az account set subcription [WHERE_THE_STORAGE_ACCOUNT_IS_TO_BE_CREATED]
```

In the "tf-manual-build-storage-account" folder, the `variable.tf` has a console updated variable for [subscription_id].

## Infrastructure Deployment ##

To deploy the infrastructure-as-code, complete the following steps:

**1. Initialize working directory containing Terraform configuration files.**

```console
$ terraform init --upgrade
```

**2. Create an execution plan, to preview the changes that Terraform plans to make to your infrastructure.**

```console
$ terraform plan -out main.tfplan
```

**3. Execute the actions proposed in a Terraform plan. -** `main.tfplan`

```console
$ terraform apply main.tfplan
```

**IF IT GOES WRONG**
```console
$ terraform apply -destroy
```

## Cleanup files ##
Execute in the "tf-manual-build-storage-account" folder
```console
rm terraform.tfstate 
rm terraform.tfstate.backup 
rm .terraform.lock.hcl 
rm *.tfplan 
rm tfplan.json
rm -r .terraform/ 
```