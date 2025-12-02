function Get-MIMSyncDatabaseName {
  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Sync'
      Property = 'Database name'
      Value    = Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Services\FIMSynchronizationService\Parameters -Name DBName
    }
  }
  catch {
    return
  }
}