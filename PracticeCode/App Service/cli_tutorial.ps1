<#
   This script walks through basic cli commands for App Service
   uncomment as you go through
   Last updated: 1-10-22
#>

# Create Resource Group
#az group create --name cliwebapp --location eastus

# Create app service plan (be aware of abreviations like g = resourcegroupname and n = name )
# create basic plan by default
# az appservice plan create -g "cliwebapp" -n mynewaps234

# Create web app
az webapp create -g cliwebapp -n mynewwebapp212121212 -p mynewaps234