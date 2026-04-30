function Get-MIMSSPRRegWindowsVersion {
  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'SSPRReg'
      Property = 'Windows version'
      Value    = Get-WindowsVersion
    }
  }
  catch {
    'Unavailable'
  }
}