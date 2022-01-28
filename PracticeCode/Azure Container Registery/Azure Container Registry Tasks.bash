ACR_NAME=bpsacr1990312

RES_GROUP=$ACR_NAME # Resource Group name

# Create Resource Group
az group create --resource-group $RES_GROUP --location eastus

# Create Container Registry
az acr create --resource-group $RES_GROUP --name $ACR_NAME --sku Standard --location eastus

# Now that you have a registry, use ACR Tasks to build a container image from the sample code
az acr build --registry $ACR_NAME --image helloacrtasks:v1 .

AKV_NAME=$ACR_NAME-vault

az keyvault create --resource-group $RES_GROUP --name $AKV_NAME

# Create service principal, store its password in AKV (the registry *password*)
az keyvault secret set \
  --vault-name $AKV_NAME \
  --name $ACR_NAME-pull-pwd \
  --value $(MSYS_NO_PATHCONV=1 az ad sp create-for-rbac \
                --name $ACR_NAME-pull \
                --scopes $(az acr show --name $ACR_NAME --query id --output tsv) \
                --role acrpull \
                --query password \
                --output tsv)

# Store service principal ID in AKV (the registry *username*)
az keyvault secret set \
    --vault-name $AKV_NAME \
    --name $ACR_NAME-pull-usr \
    --value $(az ad sp list --display-name $ACR_NAME-pull --query [].appId --output tsv)

# Deploy a container instance. The command uses the service principal's credentials stored in Azure Key Vault to authenticate to your container registry.
az container create \
    --resource-group $RES_GROUP \
    --name acr-tasks \
    --image $ACR_NAME.azurecr.io/helloacrtasks:v1 \
    --registry-login-server $ACR_NAME.azurecr.io \
    --registry-username $(az keyvault secret show --vault-name $AKV_NAME --name $ACR_NAME-pull-usr --query value -o tsv) \
    --registry-password $(az keyvault secret show --vault-name $AKV_NAME --name $ACR_NAME-pull-pwd --query value -o tsv) \
    --dns-name-label acr-tasks-$ACR_NAME \
    --query "{FQDN:ipAddress.fqdn}" \
    --output table

# To watch the startup process of the container, use the az container attach command:
az container attach --resource-group $RES_GROUP --name acr-tasks

# Stop the container instance with the az container delete command:
az container delete --resource-group $RES_GROUP --name acr-tasks

# To remove all resources you've created in this tutorial, including the container registry, key vault, and service principal
az group delete --resource-group $RES_GROUP
az ad sp delete --id http://$ACR_NAME-pull

#####################################################################################################################################

## Build on Code Commit

######################################################################################################################################

ACR_NAME=<registry-name>        # The name of your Azure container registry
GIT_USER=<github-username>      # Your GitHub user account name
GIT_PAT=<personal-access-token> # The PAT you generated in the previous section

az acr task create \
    --registry $ACR_NAME \
    --name taskhelloworld \
    --image helloworld:{{.Run.ID}} \
    --context https://github.com/$GIT_USER/acr-build-helloworld-node.git#main \
    --file Dockerfile \
    --git-access-token $GIT_PAT