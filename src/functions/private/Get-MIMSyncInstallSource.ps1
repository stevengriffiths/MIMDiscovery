function Get-MIMSyncInstallSource {
  try {
    $installSource = Get-MIMInstallSource
  }
  catch {
    $installSource = 'Unavailable'
  }
  finally {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Sync'
      Property = 'Install source'
      Value    = $installSource
    }
  }
}