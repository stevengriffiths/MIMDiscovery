function Get-MIMSSPRRegInstallPath {
  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'SSPRReg'
      Property = 'Install path'
      Value    = Get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\Microsoft\Forefront Identity Manager\2010\Password Registration Portal' -Name Location -ErrorAction Stop
    }
  }
  catch {
    return
  }
}