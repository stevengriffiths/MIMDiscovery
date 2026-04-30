function Get-MIMSyncInstallPath {
  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Sync'
      Property = 'Install path'
      Value    = Get-ItemPropertyValue -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\FIMSynchronizationService\Parameters' -Name Path -ErrorAction Stop
    }
  }
  catch {
    return
  }
}