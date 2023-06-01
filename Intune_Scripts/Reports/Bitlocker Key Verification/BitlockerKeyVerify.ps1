Function CheckBitlockerKey {
    cls
    If ((Get-BitLockerVolume -MountPoint C -ErrorAction SilentlyContinue).KeyProtector) {
        $KeyID = ((Get-BitLockerVolume -MountPoint C).KeyProtector | Where-Object -Property KeyProtectorType -EQ "RecoveryPassword").KeyProtectorId
        $RecPass = ((Get-BitLockerVolume -MountPoint C).KeyProtector | Where-Object -Property KeyProtectorType -EQ "RecoveryPassword").RecoveryPassword
    
        Write-Output "Key ID: $($KeyID)    Recovery Password: $($RecPass)"
    } Else {
        Write-Output "No Bitlocker Encryption Detected"
    }    
    Exit 0
}
CheckBitlockerKey
