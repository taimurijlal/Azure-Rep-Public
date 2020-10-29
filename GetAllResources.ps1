# Date : 28th October 2020
# Author : Taimur Ijlal
# Remarks : This script is for extracting all resources in all subscriptions into a CSV file 

 $AllSubs = @(Get-AzureRmSubscription)
	
 foreach ($SubName in $AllSubs) {
 Select-AzureRmSubscription $SubName.Name 
 $VMs = Get-AzureRmResource
 $vmOutput = $VMs | ForEach-Object { 
    [PSCustomObject]@{
        "Subscription Name" = $SubName.Name
	    "Resource Name" = $_.Name
        "Resource Group Name" = $_.ResourceGroupName
	    "Resource Type" = $_.ResourceType
        "Location" = $_.Location
    }
}
 $vmOutput | export-csv .\ResourceDump.csv -delimiter ";" -append
}
 write-host "Resources extracted from all subscriptions . Take a bow Mr. Taimur ..." 