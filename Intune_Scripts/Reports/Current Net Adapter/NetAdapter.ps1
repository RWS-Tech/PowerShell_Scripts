function getNetAdapter {
    $NetFilter = "netconnectionstatus = 2"
    $NetId = "Wi-Fi"
    $ConWLAN = "Connected to Wi-Fi"
    $ConLAN = "Connecte to Ethernet"

    $netAdap = Get-WMIObject win32_networkadapter -Filter $NetFilter | Select netconnectionid, name, interfaceindex, netconnectionstatus
    If($netAdap.netconnectionid -eq $NetId) {
        Write-Output $ConWLAN
    } Else {
        Write-Output $ConLAN
    }

    Exit 0
}
getNetAdapter