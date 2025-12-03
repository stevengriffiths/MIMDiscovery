function Get-MIMServiceConfig {
  try {
    Get-MIMServiceVersion
    Get-MIMServiceInstallAccount
    Get-MIMServiceInstallPath
    Get-MIMServiceServiceAccount
    Get-MIMServiceBaseAddress
    Get-MIMServiceAppSettings
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