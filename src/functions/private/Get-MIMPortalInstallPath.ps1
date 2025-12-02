function Get-MIMPortalInstallPath {
  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Portal'
      Property = 'Install path'
      Value    = Get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\Microsoft\Forefront Identity Manager\2010\Portal' -Name Location -ErrorAction Stop
    }
  }
  catch {
    return
  }
}