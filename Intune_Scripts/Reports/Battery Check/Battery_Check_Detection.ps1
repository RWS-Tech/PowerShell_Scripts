Function CheckBatteryHealth {
    cls
    $BatChkFile = "C:\Temp\batchk.txt"
    $BatMsgFile = "C:\Temp\batmsg.txt"
    $BatWrnLvlFile = "C:\Temp\batwrn.txt"
    $FailMsg = "Battery Failure is Imminent"
    $OkMsg = "Battery is nearing End of Life"
    $GoodMsg = "Battery is Good"
    $NoBatMsg = "No Battery Exists"
    $BatNotPresentMsg = "Battery is not present in the system."
    $DevNoBatMsg = "Device doesn't have a Battery"
    $NoHealthInfoMsg = "Unable to obtain battery health information from WMI"
    $MinHealth = "40"
    $WarnHealth = "65"

    If ( -not (Test-Path -Path $BatChkFile)) {
        
        If (Get-WmiObject win32_battery) {
            [string]$SerialNumber = (Get-WmiObject win32_bios).SerialNumber
            
            $BatteryInstances = Get-WmiObject -Namespace "ROOT\WMI" -Class "BatteryStatus" | Select-Object -ExpandProperty InstanceName

            ForEach($BatteryInstance in $BatteryInstances) {

                $BatteryDesignSpec = Get-WmiObject -Namespace "ROOT\WMI" -Class "BatteryStaticData" | Where-Object -Property InstanceName -EQ $BatteryInstance | Select-Object -ExpandProperty DesignedCapacity
                $BatteryFullCharge = Get-WmiObject -Namespace "ROOT\WMI" -Class "BatteryFullChargedCapacity" | Where-Object -Property InstanceName -EQ $BatteryInstance | Select-Object -ExpandProperty FullChargeCapacity
            
                If ($BatteryDesignSpec -eq $null -or $BatteryFullCharge -eq $null -and ((Get-WmiObject -Class Win32_BIOS | Select-Object -ExpandProperty Manufacturer) -match "Microsoft")) {
                    If (Get-WmiObject -Class MSBatteryClass -Namespace "ROOT\WMI") {
                        $MSBatteryInfo = Get-WmiObject -Class MSBatteryClass -Namespace "ROOT\WMI" | Where-Object -Property InstanceName -EQ $BatteryInstance | Select-Object FullChargeCapacity, DesignedCapacity

                        $BatteryDesignSpec = $MSBatteryInfo.DesignedCapacity
                        $BatteryFullCharge = $MSBatteryInfo.FullChargeCapacity
                    }
                }

                If ($BatteryDesignSpec -gt $null -and $BatteryFullCharge -gt $null) {
                    [int]$CurrentHealth = ($BatteryFullCharge/$BatteryDesignSpec) * 100
                    If ($CurrentHealth -le $MinHealth) {
                        Write-Output "Battery Health: $($CurrentHealth)% of Manufacturer Specification.  Design Capacity: $($BatteryDesignSpec) mWh.  Full Charge Capacity: $($BatteryFullCharge) mWh."
                        $BattMsg = $FailMsg
                        $BattWrnLvl = "1"
                        $BattMsg | Out-File $BatMsgFile
                        $BattWrnLvl | Out-File $BatWrnLvlFile
                        Exit 1
                    } Elseif ($CurrentHealth -gt $MinHealth -and $CurrentHealth -le $WarnHealth) {
                        Write-Output "Battery Health: $($CurrentHealth)% of Manufacturer Specification.  Design Capacity: $($BatteryDesignSpec) mWh.  Full Charge Capacity: $($BatteryFullCharge) mWh."
                        $BattMsg = $OkMsg
                        $BattWrnLvl = "2"
                        $BattMsg | Out-File $BatMsgFile
                        $BattWrnLvl | Out-File $BatWrnLvlFile
                        Exit 1
                    } Else {
                        Write-Output "Battery Health: $($CurrentHealth)% of Manufacturer Specification.  Design Capacity: $($BatteryDesignSpec) mWh.  Full Charge Capacity: $($BatteryFullCharge) mWh."
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
            Write-Output "Battery Check Failed"
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