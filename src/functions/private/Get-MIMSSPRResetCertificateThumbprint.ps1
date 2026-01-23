function Get-MIMSSPRResetCertificateThumbprint {
  try {
    $siteName = (Get-MIMSSPRResetSiteName).Value
    $bindings = Get-WebBinding -Name $siteName | Where-Object {$_.protocol -eq 'https'}
    if ($bindings -eq $null) {return}

    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'SSPRReset'
      Property = 'CertThumbprint'
      Value    = $bindings.certificateHash
    }
  }
  catch {
    return
  }
}