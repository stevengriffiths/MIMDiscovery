function Get-MIMServiceVersion {
  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Service'
      Property = 'Version'
      Value    = Get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products\41BF2870A320F0340B5DA41E1DCCCFAA\InstallProperties' -Name DisplayVersion -ErrorAction Stop
    }
  }
  catch {
    return
  }
}