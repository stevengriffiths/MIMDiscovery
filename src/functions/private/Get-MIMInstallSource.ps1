function Get-MIMInstallSource {
  try {
    Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall', 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall' |
      Get-ItemProperty |
      Where-Object { $_.DisplayName -eq 'Microsoft Identity Manager Synchronization Service' -or $_.DisplayName -like 'Microsoft Identity Manager Service and Portal' } |
      Select-Object -ExpandProperty InstallSource
  }
  catch {
    'Unavailable'
  }
}