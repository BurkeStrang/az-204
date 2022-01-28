

docker build -t azure-vote-front .

az account set --subscription "Azure subscription 1"

az group  create --name bps1990resourcegroup --location westus

az acr create --resource-group bps1990resourcegroup --name bps1990acr --sku Basic --admin-enabled true

az acr login --name bps1990acr

az acr show --name bps1990acr --query loginServer --output table

# tag the azure-vote-front image with the loginServer of your container registry.

docker tag azure-vote-front bps1990acr.azurecr.io/azure-vote-front:v1

# Push images to registry

docker push bps1990acr.azurecr.io/azure-vote-front:v1


az acr repository list --name bps1990acr --output table