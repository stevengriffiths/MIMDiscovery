function Get-MIMServiceServiceAccount {
  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Service'
      Property = 'Service account'
      Value    = Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Services\FIMService -Name ObjectName
    }
  }
  catch {
    return
  }
}