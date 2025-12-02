function Get-MIMServiceDatabaseName {
  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Service'
      Property = 'Database name'
      Value    = Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Services\FIMService -Name DatabaseName
    }
  }
  catch {
    return
  }
}