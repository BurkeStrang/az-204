<#
   This script walks through basic powershell cmdlets for App Service
   uncomment as you go through
   Last updated: 1-10-22
#>

# General VM Comandlets
# https://docs.microsoft.com/en-us/powershell/module/az.compute/?view=azps-7.1.0#virtual-machines

# login
# Connect-AzAccount

# Show current VM's
# Get-AzVm

# search commands
# get-command *AzWebApp*

# Create Resource Group
# New-AzResourceGroup -Name powershellwebapp -Location EastUS

# New App Service Plan
# New-AzAppServicePlan -ResourceGroupName "powershellwebapp" -name "aznewasp123" -Location "EastUS" -Tier "Free"

# create web app
New-AzWebApp -ResourceGroupName "powershellwebapp" -Name "azbpswebapp121212" -Location "EastUs" -AppServicePlan "aznewasp123"


