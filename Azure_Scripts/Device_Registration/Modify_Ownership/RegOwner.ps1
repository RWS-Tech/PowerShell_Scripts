Connect-MgGraph -NoWelcome
Connect-AzureAD

#List of device names for devices from Azure AD
$MyDevices = "",
             ""

#Removes user as owner of the device.
Function RemoveOwner {
    Param(
        [string]$DevId,
        [string]$UserId
    )
    $uoid = GetOwnerID -upname $UserId
    $doid = GetDevId -devname $DevId
    Remove-MgDeviceRegisteredOwnerByRef -DeviceId $doid -DirectoryObjectId $uoid
}

#Registers user as owner of the device
Function AddOwner {
    Param(
        [string]$DevId, 
        [string]$UserId
    )
    $uoid = GetOwnerID -upname $UserId
    $doid = GetDevId -devname $DevId
    New-MgDeviceRegisteredOwnerByRef -DeviceId $doid -OdataId "https://graph.microsoft.com/v1.0/directoryObjects/$($uoid)"
}

#Gets the AzureAD Object Id for the users using UPN
Function GetOwnerID{
    Param(
        [string]$upname
    )
    $uinfo = Get-AzureADUser -Filter "userPrincipalName eq '$($upname)'"  
    $uoid = $uinfo.ObjectId
    return $uoid
}

#Gets Device Object ID from Azure AD using device name
Function GetDevID {
    Param(
        [string]$devname
    )
    $dinfo = Get-AzureADDevice -Filter "DisplayName eq '$($devname)'"
    $doid = $dinfo.ObjectId
    return $doid
}

#Go through list of devices and remove the user as registered owner.
Function OwnerRemoval {
    $MyId = Read-Host "What is the UPN of the user that you want unregistered?"
    foreach($Device in $MyDevices) {
        RemoveOwner -DevId $Device -UserId $MyId
    }
}

cls

#Runs the OwnerRemoval Function that removes all Devices Listed in $MyDevices.
#Prompts for the UPN of the user that the device ownership will be removed from.
#OwnerRemoval

#DevId is the Device Name
#UserId is the UPN of the user that you want the device registered to
#AddOwner -DevId "" -UserId "rstadelman@benefitfocus.com"