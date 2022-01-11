<#
   This script walks through basic azure cli commands for VMs
   uncomment as you go through
   Last updated: 1-10-22
#>

# login
# az login

# create group
# remeber --location and --name are required parameters
# az group create --name cligroup --location eastus

# create vm
# az vm create --resource-group cligroup --name aznewvm2 --image win2016datacenter --admin-username bstrang