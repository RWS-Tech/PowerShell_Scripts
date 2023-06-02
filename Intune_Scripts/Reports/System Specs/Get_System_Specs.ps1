Function GetSysInfo {
    $CPUInfo = Get-WmiObject -Class Win32_Processor | Select-Object -Property [a-z]*
    $OSInfo = Get-WmiObject -Class Win32_OperatingSystem | Select-Object -Property [a-z]*
    $HDInfo = Get-CimInstance Win32_LogicalDisk | Where {$_.DeviceID -eq "C:"}
    $NetInfo = Get-WMIObject win32_networkadapter -Filter "netconnectionstatus = 2"
    $NetConInfo = $NetInfo | Select netconnectionid, name, interfaceindex, netconnectionstatus

    $PCName = $OSInfo.CSName
    $OSName = $OSInfo.Caption
    $OSVersion = $OSInfo.Version 
    $CPUName = $CPUInfo.Name 
    $CPUPCores = $CPUInfo.NumberOfCores 
    $CPUVCores = $CPUInfo.NumberOfLogicalProcessors
    $CPUBit = $CPUInfo.AddressWidth
    $RAMTotal = [Math]::Round(((($OSInfo.TotalVisibleMemorySize) / 1024) / 1024 ),0)
    $HDTotal = [Math]::Round((((($HDInfo.Size) / 1024) / 1024) / 1024),2)
    $HDFree = [Math]::Round((((($HDInfo.FreeSpace) / 1024) / 1024) / 1024),2)
    $NetName = $NetConInfo.Name 
    $NetType = $NetConInfo.NetConnectionID

    $PCNameOut = "PC Name: $($PCName) `n"
    $OSNameOut = "OS Name: $($OSName) `n"
    $OSVerOut = "OS Version: $($OSVersion) `n"
    $CPUNameOut = "Processor Name: $($CPUName) `n"
    $CPUPCoreOut = "Physical Cores: $($CPUPCores) `n"
    $CPUVCoreOut = "Virtual Cores: $($CPUVCores) `n"
    $CPUBitOut = "Processor Architecture: $($CPUBit)-Bit `n"
    $RAMTotalOut = "Installed RAM: $($RAMTotal) GB `n"
    $HDTotalOut = "Total Hard Drive Space: $($HDTotal) GB `n"
    $HDFreeOut = "Free Hard Drive Space: $($HDFree) GB `n"
    $NetNameOut = "Network Adapter Used: $($NetName) `n"
    $NetTypeOut = "Type of Network Adapter Used: $($NetType) `n"

    $SysInfoOut = "$($PCNameOut)$($OSNameOut)$($OSVerOut)$($CPUNameOut)$($CPUPCoreOut)$($CPUVCoreOut)$($CPUBitOut)$($RAMTotalOut)$($HDTotalOut)$($HDFreeOut)$($NetNameOut)$($NetTypeOut)"

    Write-Output $SysInfoOut
}
GetSysInfo