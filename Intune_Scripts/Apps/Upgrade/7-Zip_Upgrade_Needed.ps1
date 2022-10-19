# This contains the path to the 64-Bit installation.
$64BitPath = "$Env:ProgramFiles\7-Zip\7zFM.exe"

# This contains the path to the 32-Bit installation.
$32BitPath = "${Env:ProgramFiles}(x86)\7-Zip\7zFM.exe"

# The following code checks to make sure the application is installed
# at the assigned version.
If([String](Get-Item -Path $64BitPath,$32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion){
 Write-Host "Up-to-date"
}
Else {
Write-Host "Update"
}