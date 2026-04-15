function Get-MIMSyncVersion {
  #HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products\3A0BC7A52AA704F48899208B634980F5\InstallProperties
  try {
    $sp2 = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products\3A0BC7A52AA704F48899208B634980F5\InstallProperties'
    $sp3 = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products\5212A83E4B10FFC44B9FE0D26D31441E\InstallProperties'
    $version = 'Unavailable'
    if (Test-Path -Path $sp2) {
      $version = Get-ItemPropertyValue -Path $sp2 -Name DisplayVersion -ErrorAction Stop
    }
    else {
      $version = Get-ItemPropertyValue -Path $sp3 -Name DisplayVersion -ErrorAction Stop
    }
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Sync'
      Property = 'Version'
      Value    = $version
    }
  }
  catch {
    return
  }
}