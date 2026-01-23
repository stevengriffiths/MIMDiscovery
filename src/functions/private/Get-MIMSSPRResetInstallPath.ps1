function Get-MIMSSPRResetInstallPath {
  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'SSPRReset'
      Property = 'Install path'
      Value    = Get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\Microsoft\Forefront Identity Manager\2010\Password Reset Portal' -Name Location -ErrorAction Stop
    }
  }
  catch {
    return
  }
}