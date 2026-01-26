function Get-SQLAliases {
  try {
    $aliases = @{}
	$aliasLocations = @(
	  'HKLM:\SOFTWARE\Microsoft\MSSQLServer\Client\ConnectTo',
	  'HKLM:\SOFTWARE\WOW6432Node\Microsoft\MSSQLServer\Client\ConnectTo'
	)
	$aliasLocations | ForEach-Object {
      if (Test-Path $_) {
	    Get-ItemProperty -Path $_ | `
          ForEach-Object {
            $_.psobject.Properties | `
            Where-Object {$_.Name -notmatch 'PSPath|PSParentPath|PSChildName|PSDrive|PSProvider'} | `
            ForEach-Object {
              if (-not $aliases.ContainsKey($_.Name)) {
                $aliases.Add($_.Name, $_.Value.Split(',', 2)[1]) | Out-Null
              }
            }
          }
      }
	}
  }
  catch {
    Write-Verbose 'An error occurred obtaining the list of SQL aliases'
  }
  finally {
    $aliases
  }
}