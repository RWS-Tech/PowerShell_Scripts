Function DSARemoval {
	Install-PackageProvider -Name "NuGet" -MinimumVersion "2.8.5.200" -Force
        Get-Package "Dell SupportAssist" -ProviderName msi | Uninstall-Package -Force
}
DSARemoval