function Get-MIMServiceDatabaseServer {
  try {
    $aliases = Get-SQLAliases
    $dbServer = Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Services\FIMService -Name DatabaseServer
    if ($aliases.ContainsKey($dbServer)) {
      $value = '{0} ({1})' -f $dbServer, $aliases[$dbServer]
    }
    else {
      $value = $dbServer
    }
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Service'
      Property = 'Database server'
      Value    = $value
    }
  }
  catch {
    return
  }
}