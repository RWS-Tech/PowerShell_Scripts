# This contains the version to check for.
$AppVersion = "xx.x.xxxxx.x"

# This contains the path to the 64-Bit installation.
$64BitPath = "$Env:ProgramFiles\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe"

# This contains the path to the 32-Bit installation.
$32BitPath = "${Env:ProgramFiles(x86)}\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe"

# The following code checks to make sure the application is installed
# at the assigned version.
If([String](Get-Item -Path $64BitPath,$32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion -ge $AppVersion){
 Write-Host "Up-to-date"
}
Else {
Write-Host "Update"
}