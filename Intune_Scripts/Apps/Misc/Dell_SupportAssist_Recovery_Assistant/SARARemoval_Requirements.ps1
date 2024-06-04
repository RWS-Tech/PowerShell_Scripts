Function SARARemoval {
    $SARAssist = Get-Package -Name "SupportAssist Recovery Assistant"
	If($SARAssist) {
        Write-Host "Uninstall"
    } Else {
        Write-Host "Uninstalled"
    }
}
SARARemoval