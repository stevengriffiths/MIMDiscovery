function Get-MIMSyncVersion {
  #HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products\3A0BC7A52AA704F48899208B634980F5\InstallProperties
  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Sync'
      Property = 'Version'
      Value    = Get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products\3A0BC7A52AA704F48899208B634980F5\InstallProperties' -Name DisplayVersion -ErrorAction Stop
    }
  }
  catch {
    return
  }
}