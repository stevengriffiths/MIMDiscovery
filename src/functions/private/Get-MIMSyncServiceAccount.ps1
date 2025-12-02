function Get-MIMSyncServiceAccount {
  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Service'
      Property = 'Service account'
      Value    = Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Services\FIMSynchronizationService -Name ObjectName
    }
  }
  catch {
    return
  }
}