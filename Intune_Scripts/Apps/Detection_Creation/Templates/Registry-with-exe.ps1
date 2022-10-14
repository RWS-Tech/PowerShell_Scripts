# Registry location containing the key
$RegKey1 = ""
$RegKey2 = ""

# Application Display Name
$AppName = ''

# Contains the path to the exe inside the install location.
$ExeLocation = ""

$64BitRoot = "$Env:ProgramFiles\"
$32BitRoot = "${Env:ProgramFiles(x86)}\"

$App = Get-ChildItem -Path "$RegKey1","$RegKey2" | Get-ItemProperty | Where-Object {$_.DisplayName -match "$AppName" } | Select-Object -Property DisplayName, DisplayVersion, UninstallString
$AppExe = "$($App.InstallLocation)" + "$($ExeLocation)"
$AppPath = $AppExe.Replace("$64BitRoot","").Replace("$32BitRoot","")
$FileVersion = (Get-Item -:Path "$AppExe" -ErrorAction SilentlyContinue).VersionInfo.FileVersion

## Create Script File with Application Registry Detection Method
$FileAppName = "App_Name"
$FileName = $FileAppName + "_Detection_Method.ps1"
$FileRoot = "C:\Temp\"
$FilePath = $FileRoot + $FileName
$AppPath1 = "$64BitRoot" + "$AppPath"
$AppPath2 = "$32BitRoot" + "$AppPath"

New-Item -Path "$FilePath" -Force
Set-Content -Path "$FilePath" -Value "`$AppVersion = '$($FileVersion)'"
Add-Content -Path "$FilePath" -Value "`$AppPath1 = '$($AppPath1)'"
Add-Content -Path "$FilePath" -Value "`$AppPath2 = '$($AppPath2)'"
Add-Content -Path "$FilePath" -Value "If([Version](Get-ItemPropertyValue -Path `$AppPath1,`$AppPath2 -Name DisplayVersion -ea SilentlyContinue) -ge `$AppVersion) {"
Add-Content -Path "$FilePath" -Value "Write-Host `"Installed`""
Add-Content -Path "$FilePath" -Value "}"
Invoke-Item $FilePath