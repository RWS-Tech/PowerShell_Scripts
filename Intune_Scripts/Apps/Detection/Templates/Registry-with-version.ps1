# Registry path examples:
# HKLM:\SOFTWARE
# HKCU:\SOFTWARE

# This contains the version to check for.
$AppVersion = ""

# Each of these variables contain the path to different Registry Keys.
# To add more, just create a variable for each one, using the following
# format.
$RegPath1 = ""
$RegPath2 = ""

# The following code checks to make sure the application is installed
# at the assigned version.  If you only need to check one path, set $RegPath1
# as the only Path, otherwise use as many paths as you need.  Just make sure to
# put a comma, with no spaces, in between each individual path.
If([Version](Get-ItemPropertyValue -Path $RegPath1,$RegPath2 -Name DisplayVersion -ea SilentlyContinue) -ge $AppVersion){
 Write-Host "Installed"
}