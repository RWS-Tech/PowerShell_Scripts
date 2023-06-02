function DiskSpaceChk {
    $DskChkFile = "C:\Temp\dskchk.txt"
    $Percent_Alert = "10"
    $Percent_Warn = "25"
    $Win32_LogicalDisk = Get-CimInstance Win32_LogicalDisk | Where {$_.DeviceID -eq "C:"}
    $Disk_Full_Size = $Win32_LogicalDisk.Size
    $Disk_Free_Space = $Win32_LogicalDisk.FreeSpace
    $GB_Free = [Math]::Round(((($Disk_Free_Space / 1024) / 1024) / 1024),1)
    $Total_Size_NoFormat = [Math]::Round(($Disk_Full_Size))
    $GB_Total = [Math]::Round(((($Total_Size_NoFormat / 1024) / 1024) / 1024),1)
    [int]$Free_Space_Percent = '{0:N0}' -f (($Disk_Free_Space / $Total_Size_NoFormat * 100),1)
    $DskMsgFile = "C:\Temp\dskmsg.txt"
    $DskWrnFile = "C:\Temp\dskwrn.txt"
    $LowDskSpc = "Low Disk Space"
    $OkDskSpc = "Disk Space is nearing low level"
    $GoodDskSpc = "Disk Space is good"
    $DskMsg1 = "% Free: "
    $DskMsg2 = "%,  GB Free: "
    $DskMsg3 = " GB,  Total GB: "
    $DskMsg4 = " GB"

    If( -not (Test-Path -Path $DskChkFile -PathType Leaf)) {
        If($Free_Space_Percent -le $Percent_Alert) {
            Write-Output "$($DskMsg1)$($Free_Space_Percent)$($DskMsg2)$($GB_Free)$($DskMsg3)$($GB_Total)$($DskMsg4)"
            $DiskMsg = $LowDskSpc
            $DiskWrn = "1"
            $DiskMsg | Out-File $DskMsgFile
            $DiskWrn | Out-File $DskWrnFile
            Exit 1
        } Elseif (($Free_Space_Percent -gt $Percent_Alert) -and ($Free_Space_Percent -le $Percent_Warn)) {
            Write-Output "$($DskMsg1)$($Free_Space_Percent)$($DskMsg2)$($GB_Free)$($DskMsg3)$($GB_Total)$($DskMsg4)"
            $DiskMsg = $OkDskSpc
            $DiskWrn = "2"
            $DiskMsg | Out-File $DskMsgFile
            $DiskWrn | Out-File $DskWrnFile
            Exit 1
        } Elseif ($Free_Space_Percent -gt $Percent_Warn) {
            Write-Output "$($DskMsg1)$($Free_Space_Percent)$($DskMsg2)$($GB_Free)$($DskMsg3)$($GB_Total)$($DskMsg4)"
            $DiskMsg = $GoodDskSpc
            $DiskWrn = "2"
            $DiskMsg | Out-File $DskMsgFile
            $DiskWrn | Out-File $DskWrnFile
            Exit 1
        }
    } Else {
        $DiskMsg = Get-Content -Path $DskMsgFile
        $DiskWrn = Get-Content -Path $DskWrnFile

        If($DiskWrn -eq "1") {
            Write-Warning $DiskMsg
        } Else {
            Write-Output $DiskMsg
        }

        If(Test-Path -Path $DskChkFile -PathType Leaf) {
            Remove-Item -Path $DskChkFile
        }

        If (Test-Path -Path $DskMsgFile -PathType Leaf) {
            Remove-Item -Path $DskMsgFile
        }

        If(Test-Path -Path $DskWrnFile -PathType Leaf) {
            Remove-Item -Path $DskWrnFile
        }

        Exit 0
    }
}
DiskSpaceChk