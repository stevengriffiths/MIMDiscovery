function Get-MIMServiceWindowsVersion {
  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Service'
      Property = 'Windows version'
      Value    = Get-WindowsVersion
    }
  }
  catch {
    'Unavailable'
  }
}