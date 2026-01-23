function Assert-SSPRServer {
  try {
    $reg = Get-Item -Path 'HKLM:\SOFTWARE\Microsoft\Forefront Identity Manager\2010\Password Registration Portal' -ErrorAction SilentlyContinue
    $res = Get-Item -Path 'HKLM:\SOFTWARE\Microsoft\Forefront Identity Manager\2010\Password Reset Portal' -ErrorAction SilentlyContinue
    if ($reg -eq $null -and $res -eq $null) {
      $result = $false
    }
    else {
      $result = $true
    }
  }
  catch {
    $result = $false
  }
  finally {
    $result
  }
}