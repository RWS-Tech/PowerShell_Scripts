## Check for Cisco Webex (Registry Detection Method)
$RegKey1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
$RegKey2 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
$AppName = 'Webex'
$Uninstall1 = 'MsiExec.exe /I'
$Uninstall2 = 'MsiExec.exe /X'

$App = Get-ChildItem -Path $RegKey1,$RegKey2 | Get-ItemProperty | Where-Object {$_.DisplayName -match $AppName } | Select-Object -Property DisplayName, DisplayVersion, UninstallString
$App.DisplayVersion
$GUID = $App.UninstallString -replace $Uninstall1, '' -replace $Uninstall2, ''

## Create Text File with Cisco Webex Registry Detection Method
$FileAppName = "Cisco_Webex"
$FileName = $FileAppName + "_Detection_Method.ps1"
$FileRoot = "C:\Temp\"
$FilePath = $FileRoot + $FileName
$RegGUID = "\$($GUID)"
$RegPath1 = $RegKey1 + $RegGUID
$RegPath2 = $RegKey2 + $RegGUID

New-Item -Path "$FilePath" -Force
Set-Content -Path "$FilePath" -Value "`$AppVersion = '$($App.DisplayVersion)'"
Add-Content -Path "$FilePath" -Value "`$RegPath1 = '$($RegPath1)'"
Add-Content -Path "$FilePath" -Value "`$RegPath2 = '$($RegPath2)'"
Add-Content -Path "$FilePath" -Value "If([Version](Get-ItemPropertyValue -Path `$RegPath1,`$RegPath2 -Name DisplayVersion -ea SilentlyContinue) -ge `$AppVersion) {"
Add-Content -Path "$FilePath" -Value "Write-Host `"Installed`""
Add-Content -Path "$FilePath" -Value "}"
Invoke-Item $FilePath