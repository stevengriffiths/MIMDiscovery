function Assert-SyncServer {
  try {
    Get-Service -Name 'FIMSynchronizationService' -ErrorAction Stop | Out-Null
    $result = $true
  }
  catch {
    $result = $false
  }
  finally {
    $result
  }
}