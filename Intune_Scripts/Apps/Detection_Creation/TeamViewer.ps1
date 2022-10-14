# Registry location containing the key
$RegKey1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
$RegKey2 = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"

# Application Display Name
$AppName = 'TeamViewer'

# Contains the path to the exe inside the install location.
$ExeLocation = "TeamViewer.exe"

$64BitRoot = "$Env:ProgramFiles\"
$32BitRoot = "${Env:ProgramFiles(x86)}\"

$App = Get-ChildItem -Path "$RegKey1","$RegKey2" | Get-ItemProperty | Where-Object {$_.DisplayName -match "$AppName" } | Select-Object -Property DisplayName, InstallLocation
$AppExe = "$($App.InstallLocation)$ExeLocation"
$AppPath = $AppExe.Replace("$64BitRoot","").Replace("$32BitRoot","")
$FileVersion = (Get-Item -Path "$AppExe" -ErrorAction SilentlyContinue).VersionInfo.FileVersion

## Create Script File with Application Registry Detection Method
$FileAppName = "TeamViewer"
$FileName = $FileAppName + "_Detection_Method.ps1"
$FileRoot = "C:\Temp\"
$FilePath = $FileRoot + $FileName
$AppPath1 = "$64BitRoot" + "$AppPath"
$AppPath2 = "$32BitRoot" + "$AppPath"

New-Item -Path "$FilePath" -Force
Set-Content -Path "$FilePath" -Value "`$AppVersion = '$($FileVersion)'"
Add-Content -Path "$FilePath" -Value "`$AppPath1 = '$($AppPath1)'"
Add-Content -Path "$FilePath" -Value "`$AppPath2 = '$($AppPath2)'"
Add-Content -Path "$FilePath" -Value "If([Version](Get-Item -Path `$AppPath1,`$AppPath2 -ea SilentlyContinue).VersionInfo.FileVersion -ge `$AppVersion) {"
Add-Content -Path "$FilePath" -Value "Write-Host `"Installed`""
Add-Content -Path "$FilePath" -Value "}"
Invoke-Item $FilePath