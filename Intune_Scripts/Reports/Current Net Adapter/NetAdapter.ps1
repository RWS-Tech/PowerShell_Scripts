function getNetAdapter {
    cls
    $netAdap = Get-WMIObject win32_networkadapter -Filter "netconnectionstatus = 2" | Select netconnectionid, name, interfaceindex, netconnectionstatus
    If($netAdap.netconnectionid -eq "Wi-Fi") {
        Write-Output "Connected to Wi-Fi"
    } Else {
        Write-Output "Connected to Ethernet"
    }

    Exit 0
}
getNetAdapter