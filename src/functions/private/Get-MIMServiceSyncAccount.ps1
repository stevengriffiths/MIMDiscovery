function Get-MIMServiceSyncAccount {
  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Service'
      Property = 'MIM MA account'
      Value    = Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Services\FIMService -Name SynchronizationAccount
    }
  }
  catch {
    return
  }
}