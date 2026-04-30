function Get-MIMServiceInstallSource {
  try {
    $installSource = Get-MIMInstallSource
  }
  catch {
    $installSource = 'Unavailable'
  }
  finally {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Service'
      Property = 'Install source'
      Value    = $installSource
    }
  }
}