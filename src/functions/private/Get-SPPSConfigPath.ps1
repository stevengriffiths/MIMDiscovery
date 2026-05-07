function Get-SPPSConfigPath {
  try {
    $roots = @(
      'HKLM:\SOFTWARE\Microsoft\Shared Tools\Web Server Extensions\14.0',
      'HKLM:\SOFTWARE\Microsoft\Shared Tools\Web Server Extensions\15.0',
      'HKLM:\SOFTWARE\Microsoft\Shared Tools\Web Server Extensions\16.0'
    )
    foreach ($root in $roots) {
      if (Test-Path $root) {
        if ((Get-ItemProperty $root).psobject.Properties.Name -contains 'Location') {
          $location = Get-ItemPropertyValue -Path $root -Name Location
          if ($location) {
            $psconfigPath = Join-Path -Path $location -ChildPath 'BIN\psconfig.exe'
            if (Test-Path $psconfigPath) {
              break
            }
          }
        }
      }
    }
  }
  catch {
    throw $_
  }
  finally {
    $psconfigPath
  }
}