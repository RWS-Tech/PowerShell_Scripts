$ProgressPreference = "SilentlyContinue"
$ErrorActionPreference = "SilentlyContinue"

# Define the name of the application
$AppName = "Dell SupportAssist"
$AppTypeName = "Consumer"
New-EventLog -LogName Application -Source "SupportAssistUninstall_Cleanup" -ErrorAction SilentlyContinue

# Define the registry path for uninstall information
$UninstallPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"

# Function to find the product code for the given application
function Find-DSA {
    param (
        [string]$appName
    )

    # Get a list of all subkeys in the Uninstall registry path
    $appreg = Get-ItemProperty -Path $UninstallPath | Where-Object {$_.DisplayName -eq "$($appName)"} 

    $appfind = $appreg.DisplayName

    If($appfind -eq $appName) {
        $appType = Get-ItemProperty -Path 'HKLM:\SOFTWARE\DELL\SupportAssistAgent' | Select-Object -ExpandProperty Type
        If($appType -eq $AppTypeName) {
            return "Installed"
        } Else {
            "Uninstalled"
        }
    } Else {
        return "Uninstalled"
    }

}

Function DSARemoval {
    # Find the product code for the application
    $productCode = Find-DSA -appName $AppName

    If($productCode -eq "Installed") {
        Write-Output "Dell SupportAssist is installed"
        Exit 1
    } Else {
        Write-Output "Dell SupportAssist is not installed"
        Exit 0
    }
}
DSARemoval