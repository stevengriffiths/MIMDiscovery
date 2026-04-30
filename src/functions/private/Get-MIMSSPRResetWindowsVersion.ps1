function Get-MIMSSPRResetWindowsVersion {
  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'SSPRReset'
      Property = 'Windows version'
      Value    = Get-WindowsVersion
    }
  }
  catch {
    'Unavailable'
  }
}