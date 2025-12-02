function Assert-PortalServer {
  try {
    Get-Item -Path 'HKLM:\SOFTWARE\Microsoft\Forefront Identity Manager\2010\Portal' -ErrorAction Stop | Out-Null
    $result = $true
  }
  catch {
    $result = $false
  }
  finally {
    $result
  }
}