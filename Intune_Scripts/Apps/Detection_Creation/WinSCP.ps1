# 64-Bit File Path, add the rest of the file path
$64BitPath = "$Env:ProgramFiles\WinSCP\WinSCP.exe"

# 32-Bit File, add the rest of the file path
$32BitPath = "${Env:ProgramFiles(x86)}\WinSCP\WinSCP.exe"

# Check for Application (File Detection Method)
$AppExe = (Get-ChildItem -Path $64BitPath,$32BitPath -ErrorAction SilentlyContinue)
$AppExe.FullName
$AppPath = $($AppExe.FullName).Replace("$Env:ProgramFiles\","").Replace("${Env:ProgramFiles(x86)}\","")
$FileVersion = (Get-Item -Path "$($AppExe.FullName)" -ErrorAction SilentlyContinue).VersionInfo.FileVersion

# Create the script with the Application Detection Method
# Contains the name of the Application
$AppName = "WinSCP"
$FileName = $AppName + "_Detection_Method.ps1"

#Contains the location where the script will be saved
$SRoot = "C:\Temp\" 

$FilePath = $SRoot + $FileName


New-Item -Path "$FilePath" -Force
Set-Content -Path "$FilePath" -Value "`$AppVersion = '$FileVersion'"
Add-Content -Path "$FilePath" -Value "`$64BitPath = '$64BitPath'"
Add-Content -Path "$FilePath" -Value "`$32BitPath = '$32BitPath'"
Add-Content -Path "$FilePath" -Value "If([String](Get-Item -Path `$64BitPath,`$32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion -ge `$AppVersion){"
Add-Content -Path "$FilePath" -Value "Write-Host `"Installed`""
Add-Content -Path "$FilePath" -Value "}"
Invoke-Item $FilePath