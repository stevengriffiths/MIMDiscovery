function Get-MIMPortalConfig {
  try {
    Get-MIMPortalInstallPath
    Get-MIMPortalUrl
    $webApp = Get-MIMPortalWebApp
    if ($webApp) {
      Get-MIMPortalSiteName -Application $webApp
      Get-MIMPortalSitePath -Application $webApp
      Get-MIMAppPoolAccount -Application $webApp
      Get-MIMPortalAlternateUrls -Application $webApp
      Get-MIMPortalSPDatabases -Application $webApp
      Get-MIMPortalSPNs -Application $webApp
      Get-MIMPortalDelegation -Application $webApp
    }
  }
  catch {
    Write-Verbose 'An error occurred obtaining the MIM Portal configuration'
    return
  }
}