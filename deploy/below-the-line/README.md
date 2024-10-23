# Deploy demo platform to AKS via ACR #

Once the IaC Terraform Script have been successfully ran there is the need to add the correct role assignments to the 
managed identity created by the Cluster set up.

The two role assignments are ACRPull and ACRPush.

## ACRPush ##
This role assignment is created by adding the role assignment via the Azure Portal.

This role assignment is to be added to the Managed Identity that is created by Azure within the Azure
Resource Group 'MC_rg-.......'.

Scope: Resource Group
Subscription: [WHERE_THE_AKS_IS]
Resource group: [WHERE_THE_AKS_IS]
Role: AcrPush

## AcrPull ## 
This role assignment is created by a cli script:

```console
$ az login
```

```console
$ az account set subcription [WHERE_THE_AKS_IS]
```

```console
$ az aks update --name [CLUSTER_NAME] --resource-group [RESOURCE_GROUP_NAME] --attach-acr /subscriptions/[SUBSCRIPTION_ID]/resourceGroups/[RESOURCE_GROUP_NAME]/providers/Microsoft.ContainerRegistry/registries/[AZURE_CONTAINER_REGISTRY_NAME]
```
There is a delay in these propagating, you must wait for the role assignments to be added BEFORE continuing.

## Set up Ingress Controller on AKS ##

An Ingress Controller is a separate DaemonSet (a controller which runs on all nodes, including any future ones) 
along with a Service that can be used to utilize routing and proxying. NGINX is used here and acts as an old-school 
reverse proxy receiving incoming traffic and forwarding it to HTTP(S) routes defined in the Ingress resources, defined 
below.

The following code will add the kubeconfig for the Cluster to your local machine.
```console
$ az aks get-credentials --name [CLUSTER_NAME] --resource-group [RESOURCE_GROUP_NAME]
```
Once the kubeconfig is accessible, run the following command to create the Ingress Controller and the additional services the NGINX controller needs.
```console
$ kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.3/deploy/static/provider/cloud/deploy.yaml
```
Running this command will verify the Ingress Controller pods running in their own namespace.
```console
$ kubectl get pods --namespace ingress-nginx
```

[kubernetes-cheat-sheet](https://spacelift.io/blog/kubernetes-cheat-sheet)

#### Namespaces ####

Run the following command to add the namespace

```console
$ kubectl apply -f ./deploy/below-the-line/pre-deploy-run-once-namespaces.yml
```

Check ingress controller logs

```console
$ kubectl logs -n <your-ingress-controller-namespace> <your-ingress-controller-pod-name>
```

Current state of ingress object, if applicable:

```console
$ kubectl -n <your-ingress-controller-namespace> get all,ing -o wide
```

```console
$ kubectl -n <your-ingress-controller-namespace> describe ing <your-ingress-controller-name>
```