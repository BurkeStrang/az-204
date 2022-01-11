## <p align="center">Burke's Study Guide For AZ-204!
###  <p align="center">:collision: :weary: :question: :books: :computer: :headphones: :metal: :coffee: :muscle: :heavy_check_mark: :smirk:   


___

# <ins>[Azure Resource Manager](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/)
Azure Resource Manager is the deployment and management service for Azure. It provides a management layer that enables you to create, update, and delete resources in your Azure account. You use management features, like access control, locks, and tags, to secure and organize your resources after deployment.

When a user sends a request from any of the Azure tools, APIs, or SDKs, Resource Manager receives the request. It authenticates and authorizes the request. Resource Manager sends the request to the Azure service, which takes the requested action. Because all requests are handled through the same API, you see consistent results and capabilities in all the different tools.

The following image shows the role Azure Resource Manager plays in handling Azure requests.

![](AzureResourceManager.png)

## Terminology

* **resource** - A manageable item that is available through Azure. Virtual machines, storage accounts, web apps, databases, and virtual networks are examples of resources. Resource groups, subscriptions, management groups, and tags are also examples of resources.
* **resource group** - A container that holds related resources for an Azure solution. The resource group includes those resources that you want to manage as a group. You decide which resources belong in a resource group based on what makes the most sense for your organization. See Resource groups.
* **resource provider** - A service that supplies Azure resources. For example, a common resource provider is Microsoft.Compute, which supplies the virtual machine resource. Microsoft.Storage is another common resource provider. See Resource providers and types.
* **Resource Manager template** - A JavaScript Object Notation (JSON) file that defines one or more resources to deploy to a resource group, subscription, management group, or tenant. The template can be used to deploy the resources consistently and repeatedly. See Template deployment overview.
* **declarative syntax** - Syntax that lets you state "Here is what I intend to create" without having to write the sequence of programming commands to create it. The Resource Manager template is an example of declarative syntax. In the file, you define the properties for the infrastructure to deploy to Azure. See Template deployment overview.



---

# <ins>[ARM Templates](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/)


### Basics
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
### Schema
*Required*. Location of the JavaScript Object Notation (JSON) schema file that describes the version of the template language. The version number you use depends on the scope of the deployment and your JSON editor.

### Content Version
*Required*. Version of the template (such as 1.0.0.0). You can provide any value for this element. Use this value to document significant changes in your template. When deploying resources using the template, this value can be used to make sure that the right template is being used.

### API Profile
An API version that serves as a collection of API versions for resource types. Use this value to avoid having to specify API versions for each resource in the template. When you specify an API profile version and don't specify an API version for the resource type, Resource Manager uses the API version for that resource type that is defined in the profile.

The API profile property is especially helpful when deploying a template to different environments, such as Azure Stack and global Azure. Use the API profile version to make sure your template automatically uses versions that are supported in both environments.

### Resources
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
### Parameters
In the parameters section of the template, you specify which values you can input when deploying the resources. You're limited to 256 parameters in a template. You can reduce the number of parameters by using objects that contain multiple properties. To pass parameter values, you can use either inline parameters or a parameter file.

* Always use parameters for user names and passwords (or secrets).

### Template Functions
Within your template, you can create your own functions. These functions are available for use in your template. Typically, you define complicated expressions that you don't want to repeat throughout your template. You create the user-defined functions from expressions and functions that are supported in templates.

### Variables
In the variables section, you construct values that can be used throughout your template. You don't need to define variables, but they often simplify your template by reducing complex expressions. The format of each variable matches one of the data types.

### Outputs
In the outputs section, you specify values that are returned from deployment. Typically, you return values from resources that were deployed.

### Validation

### Deployment
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

# <ins>[Virtual Machines](https://docs.microsoft.com/en-us/azure/virtual-machines/)
Azure Virtual Machines (VM) is one of several types of on-demand, scalable computing resources that Azure offers. Typically, you choose a VM when you need more control over the computing environment than the other choices offer. Example below:

![](single-vm-diagram.png)

## Pwsh
Create Resource Group:
```
New-AzResourceGroup -Name powershellgrp -Location EastUS
```
Create VM:
```
New-AzVm -ResourceGroupName powershellgrp -Name aznewvm -Location EastUS -VirtualNetworkName "mynewVNet" -SubnetName "default" -SecurityGroupName "mynewNSG" -PublicIpAddressName "mypublicip" -OpenPorts 80,3389 
```


## CLI


Create a resource group with the az group create command. An Azure resource group is a logical container into which Azure resources are deployed and managed. The following example creates a resource group named myResourceGroup in the eastus location:
```
az group create --name myResourceGroup --location eastus
```
The following example creates a VM named myVM and adds a user account named azureuser. The --generate-ssh-keys parameter is used to automatically generate an SSH key, and put it in the default key location (~/.ssh). To use a specific set of keys instead, use the --ssh-key-values option.
```
az vm create \
  --resource-group myResourceGroup \
  --name myVM \
  --image UbuntuLTS \
  --admin-username azureuser \
  --generate-ssh-keys
```

## Operating Systems

Marketplace contains supported images. You can create custom images for other options.
**Windows** :
5 years of mainstream support + 5 years of extended support (10 years total)
* Server 2008 R2 SP1
* 2012 Datacenter
* 2012 Datacenter R2
* 2016 Datacenter
* 2019 Datacenter,
* 2012 Datacenter Server Core (no UI)
* 2012 Datacenter with Containers (pre-installed support for containers)
**Linux**:
Linux is not always free, depending on the distribution you choose.
* CentOS
* Ubuntu
* Red Hat Enterprise Linux (RHEL)
* Ubuntu Advantage
* SUSE Linux

## Sizes
Instance Family
* General Purpose - balanced VM
* Compute Optimized - double the CPU cores
* Memory Optimized - double the memory
* Storage Optimized - double the local storage
* GPU - access to a graphics processing unit
* High - performance Compute - fastest everything

**General Purpose - balanced VM**
“Balanced CPU-to-memory ratio. Ideal for testing and development, small to medium
databases, and low to medium traffic web servers.”
* D Series
* A Series (non-critical)
* B Series (economical)
* DC Series (preview, confidential computing)

**Compute Optimized - double the CPU cores**
“High CPU-to-memory ratio. Good for medium traffic web servers, network appliances, batch
processes, and application servers.”
* F Series

**Memory Optimized - double the memory**
“High memory-to-core ratio. Great for relational database servers, medium to large caches,
and in-memory analytics.”
* E Series
* D11-15
* G Series (includes powerful CPU for database workloads)
* M Series (certified for SAP HANA, up to 416 cores + 12 TB memory)

**Storage Optimized - double the local storage**
“High disk throughput and IO. Ideal for Big Data, SQL, and NoSQL databases.”
* L Series

**GPU - access to a graphics processing unit**
“Specialized virtual machines targeted for heavy graphic rendering and video editing
available with single or multiple GPUs.”
* N Series (incl NC, NV, ND)

**High-Performance Compute - fastest everything**
“Our fastest and most powerful CPU virtual machines with optional high-throughput network
interfaces (RDMA).”
* H Series (incl HB and HC)

## Payment Options
* Pay As You Go (PAYG) - charged by the minute
* Reserved VMs - a committment; pay for 1 or 3 years in advance, or paid monthly
* Spot Pricing - like an auction; bid on compute time only while available
* Hybrid Benefit - pay for Windows & SQL Server licenses through Enterprise
Agreement, likely cheaper


## Notes
* Permanent Storage charged separately
* Public IP addresses have a cost
* Bandwidth into Azure (egress) has a cost
* Region chosen affects pricing
* Can get Windows VM images with SQL Server, Biztalk, Sharepoint or Machine
Learning Server preinstalled, for additional licensing cost
* Can get Linux VM images with SQL Server and Machine Learning Server
preinstalled, for additional licensing cost
* the default VM size is Standard DS1

## Additional Resources

https://www.youtube.com/watch?v=iUaTq06m26g

# <ins>[Docker](https://docs.docker.com/)

Docker is an open platform for developing, shipping, and running applications. Docker enables you to separate your applications from your infrastructure so you can deliver software quickly. With Docker, you can manage your infrastructure in the same ways you manage your applications. By taking advantage of Docker’s methodologies for shipping, testing, and deploying code quickly, you can significantly reduce the delay between writing code and running it in production.

Example .net core application dockerized:

```
# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY ../engine/examples ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "aspnetapp.dll"]
```
# <ins>[Azure Container Registry](https://docs.microsoft.com/en-us/azure/container-registry/)

Azure Container Registry is a managed, private Docker registry service based on the open-source Docker Registry 2.0. Create and maintain Azure container registries to store and manage your private Docker container images and related artifacts.

Use Azure container registries with your existing container development and deployment pipelines, or use Azure Container Registry Tasks to build container images in Azure. Build on demand, or fully automate builds with triggers such as source code commits and base image updates.

## Additional Resources

https://www.youtube.com/watch?v=VcZH6AWhUGk

# <ins>[Azure Container Instances](https://docs.microsoft.com/en-us/azure/container-instances/)

Containers are becoming the preferred way to package, deploy, and manage cloud applications. Azure Container Instances offers the fastest and simplest way to run a container in Azure, without having to manage any virtual machines and without having to adopt a higher-level service.

Azure Container Instances is a great solution for any scenario that can operate in isolated containers, including simple applications, task automation, and build jobs. For scenarios where you need full container orchestration, including service discovery across multiple containers, automatic scaling, and coordinated application upgrades, we recommend Azure Kubernetes Service (AKS).

## CLI

Create a resource group:
```
az group create --name myResourceGroup --location eastus
```
Create a Container:
```
az container create --resource-group myResourceGroup --name mycontainer --image mcr.microsoft.com/azuredocs/aci-helloworld --dns-name-label aci-demo --ports 80
```
Check Status:
```
az container show --resource-group myResourceGroup --name mycontainer --query "{FQDN:ipAddress.fqdn,ProvisioningState:provisioningState}" --out table
```
Pull Container Logs:
```
az container logs --resource-group myResourceGroup --name mycontainer
```

## Aditional Resources

https://www.youtube.com/watch?v=jAWLQFi4USk
https://www.youtube.com/watch?v=7G_oDLON7Us

---

# <ins>[Azure App Serivce Web Apps](https://docs.microsoft.com/en-us/azure/app-service/)

Azure App Service enables you to build and host web apps, mobile back ends, and RESTful APIs in the programming language of your choice without managing infrastructure. It offers auto-scaling and high availability, supports both Windows and Linux, and enables automated deployments from GitHub, Azure DevOps, or any Git repo. This is platform as a service.

Spend time reading through the different plans and think about what features are available in each e.g. can auto scale on the standard plan but not the basic.
https://azure.microsoft.com/en-us/pricing/details/app-service/windows/

## Deployment Slots
Allow for multiple apps for staging and production etc. You can swap apps and set traffic percentage as needed.

## Notes
* web jobs are background jobs

## Additional Resources

https://www.youtube.com/watch?v=4BwyqmRTrx8&t=46s

# <ins> [Azure Functions](https://docs.microsoft.com/en-us/azure/azure-functions/)

Azure Functions is a serverless solution that allows you to write less code, maintain less infrastructure, and save on costs. Instead of worrying about deploying and maintaining servers, the cloud infrastructure provides all the up-to-date resources needed to keep your applications running.

##Triggers and Bindings

Triggers are what cause a function to run. A trigger defines how a function is invoked and a function must have exactly one trigger. Triggers have associated data, which is often provided as the payload of the function.

Binding to a function is a way of declaratively connecting another resource to the function; bindings may be connected as input bindings, output bindings, or both. Data from bindings is provided to the function as parameters.

You can mix and match different bindings to suit your needs. Bindings are optional and a function might have one or multiple input and/or output bindings.

Triggers and bindings let you avoid hardcoding access to other services. Your function receives data (for example, the content of a queue message) in function parameters. You send data (for example, to create a queue message) by using the return value of the function.

|Example scenario	|Trigger	|Input binding|	Output binding|
| --------------  | ------- | ----------- | ------------- |
|A new queue message arrives which runs a function to write to another queue.|	Queue*|	None|	Queue*|
|A scheduled job reads Blob Storage contents and creates a new Cosmos DB document.	|Timer|	Blob Storage|	Cosmos DB|
|The Event Grid is used to read an image from Blob Storage and a document from Cosmos DB to send an email.|	Event Grid|	Blob Storage and Cosmos DB|	SendGrid
A webhook that uses Microsoft Graph to update an Excel sheet.|	HTTP|	None|	Microsoft Graph|

Spend time going over supported bindings:
https://docs.microsoft.com/en-us/azure/azure-functions/functions-triggers-bindings?tabs=csharp

## CRON
| Expression     | Description    |  runs at   |
| -------------- | -------------- | ---------- |
| 0 * * * * *    |   every min    | 09:00:00; 09:01:00|
| 0 */5 * * * *  | every 5 min    | 09:00:00; 09:05:00|
| 0 0 * * * *    | every hour (hourly) | 09:00:00; 10:00:00; 11:00:00|
| 0 0 */6 * * *  | every 6 hours  | 06:00:00; 12:00:00; 18:00:00; 00:00:00 |
| 0 0 8-18 * * * | every hour between 8-18 | 08:00:00; 09:00:00; … 18:00:00; 08:00:00|
| 0 0 0 * * *    | every day (daily) | Mar 1, 2017 00:00:00; Mar 2, 2017 00:00:00 | 
| 0 0 10 * * *   | every day at 10:00:00 | Mar 1, 2017 10:00:00; Mar 2, 2017 10:00:00 |
| 0 0 * * * 1-5  | every hour on workdays | Mar 3 (FRI), 2017 22:00:00; Mar 3 (FRI), 2017 23:00:00; Mar 6 (MON), 2017 00:00:00|

## Notes 
* Function App name needs to be unique across azure

## Additional Resources

https://www.youtube.com/watch?v=Vxf-rOEO1q4
https://www.youtube.com/watch?v=zIfxkub7CLY

# <ins>[Azure Durable Functions](https://docs.microsoft.com/en-us/azure/azure-functions/durable/)
Durable Functions is an extension of Azure Functions that lets you write stateful functions in a serverless compute environment. The extension lets you define stateful workflows by writing orchestrator functions and stateful entities by writing entity functions using the Azure Functions programming model. Behind the scenes, the extension manages state, checkpoints, and restarts for you, allowing you to focus on your business logic.

## Function Chaining Pattern
## Fan Out/ Fan In Pattern
## Asynchronous API Pattern
## Monitor Pattern
## Human Interaction Pattern

# <ins> [Choosing an Azure Compute Service](https://docs.microsoft.com/en-us/azure/architecture/guide/technology-choices/compute-decision-tree)

Azure offers a number of ways to host your application code. The term compute refers to the hosting model for the computing resources that your application runs on. The following flowchart will help you to choose a compute service for your application.

If your application consists of multiple workloads, evaluate each workload separately. A complete solution may incorporate two or more compute services.

![](compute-choices.png)

Definitions:

* **"Lift and shift"** is a strategy for migrating a workload to the cloud without redesigning the application or making code changes. Also called rehosting. For more information, see Azure migration and modernization center.
* **Cloud optimized** is a strategy for migrating to the cloud by refactoring an application to take advantage of cloud-native features and capabilities.
The output from this flowchart is a **starting point** for consideration. Next, perform a more detailed evaluation of the service to see if it meets your needs.

## Understand the hosting models
Cloud services, including Azure services, generally fall into three categories: IaaS, PaaS, or FaaS. (There is also SaaS, software-as-a-service, which is out of scope for this article.) It's useful to understand the differences.

**Infrastructure-as-a-Service** (IaaS) lets you provision individual VMs along with the associated networking and storage components. Then you deploy whatever software and applications you want onto those VMs. This model is the closest to a traditional on-premises environment, except that Microsoft manages the infrastructure. You still manage the individual VMs.

**Platform-as-a-Service** (PaaS) provides a managed hosting environment, where you can deploy your application without needing to manage VMs or networking resources. Azure App Service is a PaaS service.

**Functions-as-a-Service** (FaaS) goes even further in removing the need to worry about the hosting environment. In a FaaS model, you simply deploy your code and the service automatically runs it. Azure Functions is a FaaS service.

There is a spectrum from IaaS to pure PaaS. For example, Azure VMs can autoscale by using virtual machine scale sets. This automatic scaling capability isn't strictly PaaS, but it's the type of management feature found in PaaS services.

In general, there is a tradeoff between control and ease of management. IaaS gives the most control, flexibility, and portability, but you have to provision, configure and manage the VMs and network components you create. FaaS services automatically manage nearly all aspects of running an application. PaaS services fall somewhere in between.

![](microsoft-cloud-models-diagram.png)

# <ins> [Azure Storage Accounts](https://docs.microsoft.com/en-us/azure/storage/blobs/)
An Azure storage account contains all of your Azure Storage data objects: blobs, file shares, queues, tables, and disks. The storage account provides a unique namespace for your Azure Storage data that's accessible from anywhere in the world over HTTP or HTTPS. Data in your storage account is durable and highly available, secure, and massively scalable.

## Replication

# <ins> [CosomosDB](https://docs.microsoft.com/en-us/azure/cosmos-db/)
Azure Cosmos DB is a fully managed NoSQL database for modern app development. Single-digit millisecond response times, and automatic and instant scalability, guarantee speed at any scale. Business continuity is assured with SLA-backed availability and enterprise-grade security. App development is faster and more productive thanks to turnkey multi region data distribution anywhere in the world, open source APIs and SDKs for popular languages. As a fully managed service, Azure Cosmos DB takes database administration off your hands with automatic management, updates and patching. It also handles capacity management with cost-effective serverless and automatic scaling options that respond to application needs to match capacity with demand.

## Partition Key
* Be a property that has a value which does not change. If a property is your partition key, you can't update that property's value.

* Have a high cardinality. In other words, the property should have a wide range of possible values.

* Spread request unit (RU) consumption and data storage evenly across all logical partitions. This ensures even RU consumption and storage distribution across your physical partitions.

Your container will require more than a few physical partitions when either of the following are true:

* Your container will have over 30,000 RU's provisioned

* Your container will store over 100 GB of data

## Indexing

## Data Consistency
Determine scenarios that warrant a particlulary consistency 

## Change Feed
# <ins> [SQL Database](https://docs.microsoft.com/en-us/azure/azure-sql/)

## Geo-Replication

# [Blob Containers]()
Azure Blob storage is Microsoft's object storage solution for the cloud. Blob storage is optimized for storing massive amounts of unstructured data. Unstructured data is data that doesn't adhere to a particular data model or definition, such as text or binary data.

Blob storage is designed for:

* Serving images or documents directly to a browser.
* Storing files for distributed access.
* Streaming video and audio.
* Writing to log files.
* Storing data for backup and restore, disaster recovery, and archiving.
* Storing data for analysis by an on-premises or Azure-hosted service.
# [Azure Authentication]()

# <ins>Glossary


**VHD** : Virtual Hard Disk

---
# <ins> Other Study Material
https://quizlet.com/de/513300250/microsoft-az-204-flash-cards/ (should be free and can use fully featured after login)

https://www.linkedin.com/learning/paths/prepare-for-the-developing-solutions-in-microsoft-azure-exam-az-204

https://www.udemy.com/course/70532-azure/?ranMID=39197&ranEAID=JVFxdTr9V80&ranSiteID=JVFxdTr9V80-djuiYD9XFBSye8cTxFzQxg&LSNPUBID=JVFxdTr9V80&utm_source=aff-campaign&utm_medium=udemyads
(can use free 7 day trial)