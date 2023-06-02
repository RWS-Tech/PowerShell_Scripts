Function BatteryCheckVerify {
    $BatChkFile = "C:\Temp\batchk.txt"
    $BatMsgFile = "C:\Temp\batmsg.txt"
    $BatWrnLvlFile = "C:\Temp\batwrn.txt"
    
    If ((Test-Path -Path $BatMsgFile -PathType Leaf) -and (Test-Path -Path $BatWrnLvlFile -PathType Leaf)) {
        $BatCheck = $true
        $BatCheck | Out-File $BatChkFile
    } Else {
        $BatCheck = $false
        $BatCheck | Out-File $BatChkFile
    }
    Exit 0
}
BatteryCheckVerify