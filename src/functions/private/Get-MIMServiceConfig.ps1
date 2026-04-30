function Get-MIMServiceConfig {
  try {
    Get-MIMServiceWindowsVersion
    Get-MIMServiceVersion
    Get-MIMServiceInstallPath
    Get-MIMServiceInstallSource
    Get-MIMServiceInstallAccount
    Get-MIMServiceServiceAccount
    Get-MIMServiceBaseAddress
    Get-MIMServiceAppSettings
    Get-MIMServiceSPNs
    Get-MIMServiceDelegation
    Get-MIMServiceDatabaseName
    Get-MIMServiceDatabaseServer
    Get-MIMServiceSyncAccount
  }
  catch {
    Write-Verbose 'An error occurred obtaining the MIM Service configuration'
    return
  }
}