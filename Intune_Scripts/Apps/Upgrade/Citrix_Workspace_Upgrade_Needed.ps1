$ApplicationName = "Citrix Workspace(DV)"
If((Get-ChildItem -Path REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall | Get-ItemProperty | Where-Object { $_.DisplayName -eq $ApplicationName })) {
Write-Host "Update"
}
Else {
Write-Host "Not Installed"
}