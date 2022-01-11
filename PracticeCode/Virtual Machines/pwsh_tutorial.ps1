<#
   This script walks through basic powershell cmdlets for VMs
   uncomment as you go through
   Last updated: 1-10-22
#>

# General VM Comandlets
# https://docs.microsoft.com/en-us/powershell/module/az.compute/?view=azps-7.1.0#virtual-machines

# login
# Connect-AzAccount

# Show current VMs
# Get-AzVm

# Create Resource Group
# New-AzResourceGroup -Name powershellgrp -Location EastUS

# Create VM
# New-AzVm -ResourceGroupName powershellgrp -Name aznewvm -Location EastUS -VirtualNetworkName "mynewVNet" -SubnetName "default" -SecurityGroupName "mynewNSG" -PublicIpAddressName "mypublicip" -OpenPorts 80,3389 

# Stop VM
# Stop-AzVm -ResourceGroupName "powershellgrp" -Name "aznewvm" 

# Start VM
Start-AzVM -ResourceGroupName "powershellgrp" -Name "aznewvm"