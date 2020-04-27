# Date : 27th April 2020 
# Author : Taimur Ijlal
# Remarks : This script is for extracting all of the public IPs in a subscription 


 $AllSubs = @(Get-AzureRmSubscription)
	
 foreach ($SubName in $AllSubs) {

 Select-AzureRmSubscription $SubName.Name 

 $PublicIPs = Get-AzureRmPublicIpAddress

 $vmOutput = $PublicIPs | ForEach-Object { 

    [PSCustomObject]@{
        "Subscription Name" = $SubName.Name
	"IP Name" = $_.Name
	"Resource Group Name" = $_.ResourceGroupName
        "IP Address" = $_.IPAddress
        "IP Allocation Method" = $_.PublicIPallocationmethod

    }

}

 $vmOutput | export-csv .\PublicIP-dump.csv -delimiter ";" -append

}

 write-host "List of Public IPs extracted. Take a bow Mr. Taimur ..." 
