##<center><ins>Burke's Study Guide For AZ-204 Domination!</center>
###<center> :collision: :weary: :question: :books: :computer: :headphones: :metal: :coffee: :muscle: :heavy_check_mark: :smirk:</center>     


___

#<ins>[Azure Resource Manager](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/)
Azure Resource Manager is the deployment and management service for Azure. It provides a management layer that enables you to create, update, and delete resources in your Azure account. You use management features, like access control, locks, and tags, to secure and organize your resources after deployment.

When a user sends a request from any of the Azure tools, APIs, or SDKs, Resource Manager receives the request. It authenticates and authorizes the request. Resource Manager sends the request to the Azure service, which takes the requested action. Because all requests are handled through the same API, you see consistent results and capabilities in all the different tools.

The following image shows the role Azure Resource Manager plays in handling Azure requests.

![](AzureResourceManager.png)

##Terminology

* **resource** - A manageable item that is available through Azure. Virtual machines, storage accounts, web apps, databases, and virtual networks are examples of resources. Resource groups, subscriptions, management groups, and tags are also examples of resources.
* **resource group** - A container that holds related resources for an Azure solution. The resource group includes those resources that you want to manage as a group. You decide which resources belong in a resource group based on what makes the most sense for your organization. See Resource groups.
* **resource provider** - A service that supplies Azure resources. For example, a common resource provider is Microsoft.Compute, which supplies the virtual machine resource. Microsoft.Storage is another common resource provider. See Resource providers and types.
* **Resource Manager template** - A JavaScript Object Notation (JSON) file that defines one or more resources to deploy to a resource group, subscription, management group, or tenant. The template can be used to deploy the resources consistently and repeatedly. See Template deployment overview.
* **declarative syntax** - Syntax that lets you state "Here is what I intend to create" without having to write the sequence of programming commands to create it. The Resource Manager template is an example of declarative syntax. In the file, you define the properties for the infrastructure to deploy to Azure. See Template deployment overview.



---

#<ins>[ARM Templates](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/)


###Basics
ARM templates are JSON files where you define what you want to deploy to Azure. Templates help you implement an infrastructure-as-code solution for Azure. Your organization can repeatedly and reliably deploy the required infrastructure to different environments.

In its simplest structure, a template has the following elements:
```
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "",
  "apiProfile": "",
  "parameters": {  },
  "variables": {  },
  "functions": [  ],
  "resources": [  ],
  "outputs": {  }
} 
```
###Schema
*Required*. Location of the JavaScript Object Notation (JSON) schema file that describes the version of the template language. The version number you use depends on the scope of the deployment and your JSON editor.

###Content Version
*Required*. Version of the template (such as 1.0.0.0). You can provide any value for this element. Use this value to document significant changes in your template. When deploying resources using the template, this value can be used to make sure that the right template is being used.

###API Profile
An API version that serves as a collection of API versions for resource types. Use this value to avoid having to specify API versions for each resource in the template. When you specify an API profile version and don't specify an API version for the resource type, Resource Manager uses the API version for that resource type that is defined in the profile.

The API profile property is especially helpful when deploying a template to different environments, such as Azure Stack and global Azure. Use the API profile version to make sure your template automatically uses versions that are supported in both environments.

###Resources
*Required*. In the resources section, you define the resources that are deployed or updated.

Example:
```
"resources": [
  {
    "type": "Microsoft.Storage/storageAccounts",
    "apiVersion": "2018-07-01",
    "name": "[concat('storage', uniqueString(resourceGroup().id))]",
    "comments": "Storage account used to store VM disks",
    "location": "[parameters('location')]",
    "metadata": {
      "comments": "These tags are needed for policy compliance."
    },
    "tags": {
      "Dept": "[parameters('deptName')]",
      "Environment": "[parameters('environment')]"
    },
    "sku": {
      "name": "Standard_LRS"
    },
    "kind": "Storage",
    "properties": {}
  }
]
```
###Parameters
In the parameters section of the template, you specify which values you can input when deploying the resources. You're limited to 256 parameters in a template. You can reduce the number of parameters by using objects that contain multiple properties. To pass parameter values, you can use either inline parameters or a parameter file.

* Always use parameters for user names and passwords (or secrets).

###Template Functions
Within your template, you can create your own functions. These functions are available for use in your template. Typically, you define complicated expressions that you don't want to repeat throughout your template. You create the user-defined functions from expressions and functions that are supported in templates.

###Variables
In the variables section, you construct values that can be used throughout your template. You don't need to define variables, but they often simplify your template by reducing complex expressions. The format of each variable matches one of the data types.

###Outputs
In the outputs section, you specify values that are returned from deployment. Typically, you return values from resources that were deployed.

###Validation

###Deployment
Deployment Options: Portal, CLI, Powershell, REST API, GITHub, Cloud Shell


**Azure CLI**

To deploy to a resource group use: 
```
az deployment group create --resource-group <resource-group-name> --template-file <path-to-template>
```
To deploy to a subscription:
```
az deployment sub create --location <location> --template-file <path-to-template>
```
To deploy to a management group:
```
az deployment mg create --location <location> --template-file <path-to-template>
```
To deploy to a tenant:
```
az deployment tenant create --location <location> --template-file <path-to-template>
```
##Additional Resources
https://www.youtube.com/watch?v=Ge_Sp-1lWZ4&t=21s
https://azure.microsoft.com/en-us/resources/templates/

---

#<ins>[Virtual Machines](https://docs.microsoft.com/en-us/azure/virtual-machines/)
Azure Virtual Machines (VM) is one of several types of on-demand, scalable computing resources that Azure offers. Typically, you choose a VM when you need more control over the computing environment than the other choices offer.

#<ins>[Azure Container Registry](https://docs.microsoft.com/en-us/azure/container-registry/)

Azure Container Registry is a managed, private Docker registry service based on the open-source Docker Registry 2.0. Create and maintain Azure container registries to store and manage your private Docker container images and related artifacts.

Use Azure container registries with your existing container development and deployment pipelines, or use Azure Container Registry Tasks to build container images in Azure. Build on demand, or fully automate builds with triggers such as source code commits and base image updates.

#<ins>Glossary


**VHD** : Virtual Hard Disk

---

