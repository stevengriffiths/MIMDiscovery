function Get-MIMSyncSqlServerVersion {
  try {
    $server = Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Services\FIMSynchronizationService\Parameters -Name Server
    $database = Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Services\FIMSynchronizationService\Parameters -Name DBName

    $params = @{
      DBServer = $server
      Database = $database
      SQL = 'SELECT @@VERSION AS Version'
    }
    $version = (Invoke-SQLQuery @params).Version
  }
  catch {
    $version = 'Unavailable'
  }
  finally {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Sync'
      Property = 'SQL version'
      Value    = $version
    }
  }
}