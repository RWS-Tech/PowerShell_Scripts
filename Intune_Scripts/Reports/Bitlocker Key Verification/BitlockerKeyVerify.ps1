Function CheckBitlockerKey {
    $BlProp = "RecoveryPassword"
    $BlMsg1 = "Key ID: "
    $BlMsg2 = "    Recovery Password: "
    $NoBl = "No Bitlocker Encryption Detected"
    
    If ((Get-BitLockerVolume -MountPoint C -ErrorAction SilentlyContinue).KeyProtector) {
        $KeyID = ((Get-BitLockerVolume -MountPoint C).KeyProtector | Where-Object -Property KeyProtectorType -EQ $BlProp).KeyProtectorId
        $RecPass = ((Get-BitLockerVolume -MountPoint C).KeyProtector | Where-Object -Property KeyProtectorType -EQ $BlProp).RecoveryPassword
    
        Write-Output "$(BlMsg1)$($KeyID)$($BlMsg2)$($RecPass)"
    } Else {
        Write-Output $NoBl
    }    
    Exit 0
}
CheckBitlockerKey
