function Get-WindowsVersion {
  try {
    $os = Get-CimInstance Win32_OperatingSystem
    $cv = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion'
    $patch = $cv.UBR
    $fullVersion = "{0} {1}.{2}" -f $cv.ProductName, $os.Version, $patch
    $fullVersion
  }
  catch {
    'Unavailable'
  }
}