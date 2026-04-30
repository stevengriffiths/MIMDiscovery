function Get-MIMPortalWindowsVersion {
  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Portal'
      Property = 'Windows version'
      Value    = Get-WindowsVersion
    }
  }
  catch {
    'Unavailable'
  }
}