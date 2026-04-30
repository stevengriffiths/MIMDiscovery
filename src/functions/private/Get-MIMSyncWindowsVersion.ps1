function Get-MIMSyncWindowsVersion {
  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Sync'
      Property = 'Windows version'
      Value    = Get-WindowsVersion
    }
  }
  catch {
    'Unavailable'
  }
}