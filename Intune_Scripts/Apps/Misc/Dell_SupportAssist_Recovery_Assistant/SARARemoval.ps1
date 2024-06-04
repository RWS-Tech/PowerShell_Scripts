Function SARARemoval {
    Install-PackageProvider -Name "NuGet" -MinimumVersion "2.8.5.200" -Force
	Get-Package -ProviderName msi -Name "SupportAssist Recovery Assistant" -ErrorAction SilentlyContinue | Uninstall-Package
}
SARARemoval