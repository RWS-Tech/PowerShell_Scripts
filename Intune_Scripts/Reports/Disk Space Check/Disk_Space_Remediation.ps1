Function DiskSpaceVerify {
    $DskMsgFile = "C:\Temp\dskmsg.txt"
    $DskWrnFile = "C:\Temp\dskwrn.txt"
    $DskChkFile = "C:\Temp\dskchk.txt"
    
    If((Test-Path -Path $DskMsgFile -PathType Leaf) -and (Test-Path -Path $DskWrnFile -PathType Leaf)) {
        $DiskChk = $true
        $DiskChk | Out-File $DskChkFile
        Exit 0
    } Else {
        $DiskChk = $false
        $DiskChk | Out-File $DskChkFile
        Exit 0
    }
}
DiskSpaceVerify