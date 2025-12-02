function Get-MIMSyncDatabaseServer {
  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Sync'
      Property = 'Database server'
      Value    = Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Services\FIMSynchronizationService\Parameters -Name Server
    }
  }
  catch {
    return
  }
}