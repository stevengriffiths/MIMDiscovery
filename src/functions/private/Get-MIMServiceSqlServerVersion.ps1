function Get-MIMServiceSqlServerVersion {
  try {
    $server = Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Services\FIMService -Name DatabaseServer
    $database = Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Services\FIMService -Name DatabaseName

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
      Role     = 'Service'
      Property = 'SQL version'
      Value    = $version
    }
  }
}