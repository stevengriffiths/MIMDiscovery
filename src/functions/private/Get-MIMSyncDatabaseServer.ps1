function Get-MIMSyncDatabaseServer {
  try {
    $aliases = Get-SQLAliases
    $dbServer = Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Services\FIMSynchronizationService\Parameters -Name Server
    if ($aliases.ContainsKey($dbServer)) {
      $value = '{0} ({1})' -f $dbServer, $aliases[$dbServer]
    }
    else {
      $value = $dbServer
    }
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Sync'
      Property = 'Database server'
      Value    = $value
    }
  }
  catch {
    return
  }
}