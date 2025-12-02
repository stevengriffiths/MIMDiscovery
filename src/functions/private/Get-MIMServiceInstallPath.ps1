function Get-MIMServiceInstallPath {
  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Service'
      Property = 'Install path'
      Value    = Get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\Microsoft\Forefront Identity Manager\2010\Service' -Name Location -ErrorAction Stop
    }
  }
  catch {
    return
  }
}