function Assert-ServiceServer {
  try {
    Get-Service -Name 'FIMService' -ErrorAction Stop | Out-Null
    $result = $true
  }
  catch {
    $result = $false
  }
  finally {
    $result
  }
}