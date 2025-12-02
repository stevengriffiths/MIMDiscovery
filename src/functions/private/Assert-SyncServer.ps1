function Assert-SyncServer {
  try {
    Get-Service-Name 'FIMSynchronizationService'  | Out-Null
    $result = $true
  }
  catch {
    $result = $false
  }
  finally {
    $result
  }
}