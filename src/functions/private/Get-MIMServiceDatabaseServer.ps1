function Get-MIMServiceDatabaseServer {
  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Service'
      Property = 'Database server'
      Value    = Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Services\FIMService -Name DatabaseServer
    }
  }
  catch {
    return
  }
}