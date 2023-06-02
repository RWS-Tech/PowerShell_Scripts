Function CheckBatteryHealth {
    $BatChkFile = "C:\Temp\batchk.txt"
    $BatMsgFile = "C:\Temp\batmsg.txt"
    $BatWrnLvlFile = "C:\Temp\batwrn.txt"
    $FailMsg = "Battery Failure is Imminent"
    $OkMsg = "Battery is nearing End of Life"
    $GoodMsg = "Battery is Good"
    $NoBatMsg = "No Battery Exists"
    $BatNotPresentMsg = "Battery not present in the system."
    $DevNoBatMsg = "Device doesn't have a Battery"
    $NoHealthInfoMsg = "Unable to obtain battery health information from WMI"
    $OName = "ROOT\WMI"
    $BatStat = "BatteryStatus"
    $BatStatDat = "BatteryStaticData"
    $BatFullCap = "BatteryFullChargedCapacity"
    $BatHlt1 = "Battery Health: "
    $BatHlt2 = "% of Manufacturer Specification.  Design Capacity: "
    $BatHlt3 = " mWh.  Full Charge Capacity: "
    $BatHlt4 = " mWh."
    $ChkFailed = "Battery Check Failed"
    $MinHealth = "40"
    $WarnHealth = "65"

    If ( -not (Test-Path -Path $BatChkFile)) {
        
        If (Get-WmiObject win32_battery) {
            [string]$SerialNumber = (Get-WmiObject win32_bios).SerialNumber
            
            $BatteryInstances = Get-WmiObject -Namespace $OName -Class $BatStat | Select-Object -ExpandProperty InstanceName

            ForEach($BatteryInstance in $BatteryInstances) {

                $BatteryDesignSpec = Get-WmiObject -Namespace $OName -Class $BatStatDat | Where-Object -Property InstanceName -EQ $BatteryInstance | Select-Object -ExpandProperty DesignedCapacity
                $BatteryFullCharge = Get-WmiObject -Namespace $OName -Class $BatFullCap | Where-Object -Property InstanceName -EQ $BatteryInstance | Select-Object -ExpandProperty FullChargeCapacity
            
                If ($BatteryDesignSpec -eq $null -or $BatteryFullCharge -eq $null -and ((Get-WmiObject -Class Win32_BIOS | Select-Object -ExpandProperty Manufacturer) -match "Microsoft")) {
                    If (Get-WmiObject -Class MSBatteryClass -Namespace $OName) {
                        $MSBatteryInfo = Get-WmiObject -Class MSBatteryClass -Namespace $OName | Where-Object -Property InstanceName -EQ $BatteryInstance | Select-Object FullChargeCapacity, DesignedCapacity

                        $BatteryDesignSpec = $MSBatteryInfo.DesignedCapacity
                        $BatteryFullCharge = $MSBatteryInfo.FullChargeCapacity
                    }
                }

                If ($BatteryDesignSpec -gt $null -and $BatteryFullCharge -gt $null) {
                    [int]$CurrentHealth = ($BatteryFullCharge/$BatteryDesignSpec) * 100
                    If ($CurrentHealth -le $MinHealth) {
                        Write-Output "$($BatHlt1)$($CurrentHealth)$($BatHlt2)$($BatteryDesignSpec)$($BatHlt3)$($BatteryFullCharge)$($BatHlt4)"
                        $BattMsg = $FailMsg
                        $BattWrnLvl = "1"
                        $BattMsg | Out-File $BatMsgFile
                        $BattWrnLvl | Out-File $BatWrnLvlFile
                        Exit 1
                    } Elseif ($CurrentHealth -gt $MinHealth -and $CurrentHealth -le $WarnHealth) {
                        Write-Output "$($BatHlt1)$($CurrentHealth)$($BatHlt2)$($BatteryDesignSpec)$($BatHlt3)$($BatteryFullCharge)$($BatHlt4)"
                        $BattMsg = $OkMsg
                        $BattWrnLvl = "2"
                        $BattMsg | Out-File $BatMsgFile
                        $BattWrnLvl | Out-File $BatWrnLvlFile
                        Exit 1
                    } Else {
                        Write-Output "$($BatHlt1)$($CurrentHealth)$($BatHlt2)$($BatteryDesignSpec)$($BatHlt3)$($BatteryFullCharge)$($BatHlt4)"
                        $BattMsg = $GoodMsg
                        $BattWrnLvl = "2"
                        $BattMsg | Out-File $BatMsgFile
                        $BattWrnLvl | Out-File $BatWrnLvlFile
                        Exit 1
                    }
                } Else {
                    Write-Output $BatNotPresentMsg
                    $BattMsg = $NoBatMsg
                    $BattWrnLvl = "2"
                    $BattMsg | Out-File $BatMsgFile
                    $BattWrnLvl | Out-File $BatWrnLvlFile
                    Exit 0
                }
            }
        } Else {
            Write-Output $NoHealthInfoMsg
            $BattMsg = $DevNoBatMsg
            $BattWrnLvl = "2"
            $BattMsg | Out-File $BatMsgFile
            $BattWrnLvl | Out-File $BatWrnLvlFile
            Exit 0
        }
    } Else {
        $BatCheck = Get-Content $BatChkFile
        If ($BatCheck -eq $true) {
            $BattWrnLvl = Get-Content $BatWrnLvlFile
            $BattMsg = Get-Content $BatMsgFile
            If ($BattWrnLvl -eq "1") {
                Write-Warning $BattMsg
            } Else {
                Write-Output $BattMsg
            }
        } Else {
            Write-Output $ChkFailed
        }

        If (Test-Path -Path $BatMsgFile -PathType Leaf) {
            Remove-Item $BatMsgFile
        }

        If (Test-Path -Path $BatWrnLvlFile -PathType Leaf) {
            Remove-Item $BatWrnLvlFile
        }

        If (Test-Path -Path $BatChkFile -PathType Leaf) {
            Remove-Item $BatChkFile
        }

        Exit 0
    }
}
CheckBatteryHealth