function Assert-ServiceServer {
  try {
    Get-Service -Name 'FIMService'  | Out-Null
    $result = $true
  }
  catch {
    $result = $false
  }
  finally {
    $result
  }
}