## Check for Adobe Reader DC (File Detection Method)
$ReaderDC = Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall","HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | Get-ItemProperty | Where-Object {$_.DisplayName -match 'Adobe Acrobat Reader DC' } | Select-Object -Property DisplayName, InstallLocation
$ReaderDCExe = "$($ReaderDC.InstallLocation)Reader\AcroRd32.exe"
$ReaderDCPath = $ReaderDCExe.Replace("C:\Program Files\","").Replace("C:\Program Files (x86)\","")
$FileVersion = (Get-Item -Path "$ReaderDCExe" -ErrorAction SilentlyContinue).VersionInfo.FileVersion
# Registry location containing the key
$RegKey1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
$RegKey2 = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"

# Application Display Name
$AppName = 'Adobe Acrobat Reader DC'

# Contains the path to the exe inside the install location.
$ExeLocation = "Reader\AcroRd32.exe"

$64BitRoot = "$Env:ProgramFiles\"
$32BitRoot = "${Env:ProgramFiles(x86)}\"

$App = Get-ChildItem -Path "$RegKey1","$RegKey2" | Get-ItemProperty | Where-Object {$_.DisplayName -match "$AppName" } | Select-Object -Property DisplayName, InstallLocation
$AppExe = "$($App.InstallLocation)$ExeLocation"
$AppPath = $AppExe.Replace("$64BitRoot","").Replace("$32BitRoot","")
$FileVersion = (Get-Item -Path $AppExe -ErrorAction SilentlyContinue).VersionInfo.FileVersion

## Create Script File with Application Registry Detection Method
$FileAppName = "Adobe_Reader_DC"
$FileName = $FileAppName + "_Detection_Method.ps1"
$FileRoot = "C:\Temp\"
$FilePath = $FileRoot + $FileName
$AppPath1 = "$64BitRoot" + "$AppPath"
$AppPath2 = "$32BitRoot" + "$AppPath"

New-Item -Path "$FilePath" -Force
Set-Content -Path "$FilePath" -Value "`$AppVersion = '$($FileVersion)'"
Add-Content -Path "$FilePath" -Value "`$AppPath1 = '$($AppPath1)'"
Add-Content -Path "$FilePath" -Value "`$AppPath2 = '$($AppPath2)'"
Add-Content -Path "$FilePath" -Value "If([Version](Get-ItemPropertyValue -Path `$AppPath1,`$AppPath2 -ea SilentlyContinue).VersionInfo.FileVersion -ge `$AppVersion) {"
Add-Content -Path "$FilePath" -Value "Write-Host `"Installed`""
Add-Content -Path "$FilePath" -Value "}"
Invoke-Item $FilePath