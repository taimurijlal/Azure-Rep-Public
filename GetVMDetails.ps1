# Date : 2nd Feb 2020
# Author : Taimur Ijlal
# Remarks : This script is for downloading details of Azure VMs in all the subscriptions 


 $AllSubs = @(Get-AzureRmSubscription)
	
 foreach ($SubName in $AllSubs) {

 Select-AzureRmSubscription $SubName.Name 

 $VMs = Get-AzureRmVM

 $vmOutput = $VMs | ForEach-Object { 

    [PSCustomObject]@{
        "Subscription Name" = $SubName.Name
	"VM Name" = $_.Name
	"Location" = $_.Location
        "VM Type" = $_.StorageProfile.osDisk.osType
        "VM Profile" = $_.HardwareProfile.VmSize

    }

}

 $vmOutput | export-csv .\VM-dump.csv -delimiter ";" -append

}

 write-host "VM list extracted. Take a bow Mr. Taimur ..." 
