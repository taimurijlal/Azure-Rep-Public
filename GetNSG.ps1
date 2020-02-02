# Date : 2nd Feb 2020
# Author : Taimur Ijlal
# Remarks : This script is for downloading NSG rules of all subscriptions from Azure 


 $AllSubs = @(Get-AzureRmSubscription)
	
 foreach ($SubName in $AllSubs) {

 Select-AzureRmSubscription $SubName.Name 

 $nsgs = Get-AzureRmNetworkSecurityGroup 

 foreach ($nsg in $nsgs)

	{


       $nsgRules = $nsg.SecurityRules | ForEach-Object{

		 [PSCustomObject]@{
	   
		     "Subscription Name" = $SubName.Name

		     "NSG Name" = $nsg.name 

  		     "Rule Name" = $_.name

		     "Description" = $_.description

		     "Priority" = $_.priority

	 	     "Source Address Prefix" = $_.SourceAddressPrefix -join "  |  "

		     "Source Port Range" = $_.SourcePortRange -join "  |  "

		     "Destination Address Prefix" = $_.DestinationAddressPrefix -join "  |  "

		     "Destination Port Range" = $_.DestinationPortRange -join "  |  "

		     "Protocol" = $_.protocol 

		     "Access" = $_.access

		     "Direction" = $_.direction 

	          }

	}	

$nsgRules | export-csv .\NSG-Dump.csv -delimiter ";" -append

}

}

 write-host "NSG list extracted. Take a bow Mr. Taimur ..." 
