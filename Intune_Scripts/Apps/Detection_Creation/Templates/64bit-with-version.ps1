# 64-Bit File Path, add the rest of the file path
$64BitPath = "$Env:ProgramFiles\"

# Check for Application (File Detection Method)
$AppExe = (Get-ChildItem -Path $64BitPath -ErrorAction SilentlyContinue)
$AppExe.FullName
$AppPath = $($AppExe.FullName).Replace("$Env:ProgramFiles\","")
$FileVersion = (Get-Item -Path "$($AppExe.FullName)" -ErrorAction SilentlyContinue).VersionInfo.FileVersion

# Create the script with the Application Detection Method
# Contains the name of the Application
$AppName = "App_Name"
$FileName = $AppName + "_Detection_Method.ps1"

#Contains the location where the script will be saved
$SRoot = "C:\Temp\" 

$FilePath = $SRoot + $FileName


New-Item -Path "$FilePath" -Force
Set-Content -Path "$FilePath" -Value "`$AppVersion = '$FileVersion'"
Add-Content -Path "$FilePath" -Value "`$64BitPath = '$64BitPath'"
Add-Content -Path "$FilePath" -Value "If([String](Get-Item -Path `$64BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion -ge `$AppVersion){"
Add-Content -Path "$FilePath" -Value "Write-Host `"Installed`""
Add-Content -Path "$FilePath" -Value "}"
Invoke-Item $FilePath