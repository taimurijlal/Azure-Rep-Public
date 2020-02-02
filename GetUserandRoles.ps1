# Date : 2nd Feb 2020
# Author : Taimur Ijlal
# Remarks : This script is for downloading users roles and the access those roles have. Two CSV files are generated 


  $AzUsers=get-azureaduser

    ForEach ($AUser in $AzUsers){

	$UserOutput = get-azureadusermembership -ObjectId $AUser.ObjectId | ForEach-Object {

		[PSCustomObject]@{
	   
   		     "User Name" = $AUser.DisplayName
   		     "User Principal Name" = $AUser.UserPrincipalName
#		     "Object ID" = $AUser.ObjectId
		     "Role/Group Name" = $_.DisplayName
    		     "User Type" = $AUser.UserType


	}

		     write-host "Getting users in role : " $_.DisplayName
		
        }


   	$UserOutput | export-csv .\UserRoleList.csv -delimiter ";" -Append
    } 

	
 write-host "User list extracted. Moving to roles" 




 $AllSubs = @(Get-AzureRmSubscription)
	
 foreach ($SubName in $AllSubs) {

 write-host "Getting Role RBAC for" $SubName.Name

 $RoleOutput = Get-AzureRmRoleAssignment -scope "/subscriptions/$SubName" | foreach{


	[PSCustomObject]@{
	   
   		     "Subscription Name" =  $Subname.Name
   		     "Role / Group Name" = $_.DisplayName
		     "Object type" = $_.ObjectType
		     "Role Definition" = $_.RoleDefinitionName
#		     "Action" = (Get-AzureRmRoleDefinition -Name $_.roledefinitionname).actions

		}

	}	

	$RoleOutput | export-csv .\RoleRBAC.csv -delimiter ";" -Append

   }


 write-host "Role RBAC list extracted. Take a bow Mr. Taimur ..." 