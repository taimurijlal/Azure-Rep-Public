# Date : 3rd March 2021 
# Author : Taimur Ijlal
# Remarks : This script is for assigning a role to a particular user in all subs  . Replace the SigninName with the user you want to give access to 
# 	    and the role name with the role you want given access to 

 $AllSubs = @(Get-AzureRmSubscription)
	
 foreach ($SubName in $AllSubs) {

	 Select-AzureRmSubscription $SubName.Name 
	 New-AzRoleAssignment -SignInName NimeshS@larijpnetwork.onmicrosoft.com -RoleDefinitionName "Reader" -Scope /subscriptions/$SubName
    
}