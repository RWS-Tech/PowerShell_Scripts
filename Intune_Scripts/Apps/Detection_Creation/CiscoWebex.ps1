# Check for Cisco Webex (Registry Detection Method)
$Webex = Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall","HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | Get-ItemProperty | Where-Object {$_.DisplayName -match 'Webex'} | Select-Object -Property DisplayName, DisplayVersion, UninstallString
$Webex.DisplayVersion
$GUID = Webex.UninstallString -replace 'MsiExec.exe /I', '' -replace 'MsiExec.exe /X', ''

# Create .ps1 file with Cisco Webex Registy Detection Method
# Change filepath to where ever you would like the script to be saved
$FilePath = "C:\Temp\Cisco_Webex_Detection_Method.ps1"
New-Item -Path "$FilePath" -Force
Set-Content -Path "$FilePath" -Value "If([Version](Get-ItemPropertyValue -Path 'KLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$($GUID)','HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$($GUID)' -Name DisplayVersion -ea SilentlyContinue) -ge '$($Webex.DisplayVersion)') {"
Add-Content -Path "$FilePath" -Value "Write-Host `"Installed`""