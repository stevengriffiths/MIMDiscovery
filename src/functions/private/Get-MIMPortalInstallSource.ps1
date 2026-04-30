function Get-MIMPortalInstallSource {
  try {
    $installSource = Get-MIMInstallSource
  }
  catch {
    $installSource = 'Unavailable'
  }
  finally {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Portal'
      Property = 'Install source'
      Value    = $installSource
    }
  }
}