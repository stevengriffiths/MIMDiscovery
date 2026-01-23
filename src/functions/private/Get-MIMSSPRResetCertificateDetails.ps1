function Get-MIMSSPRResetCertificateDetails {
  try {
    $siteName = (Get-MIMSSPRResetSiteName).Value
    $bindings = Get-WebBinding -Name $siteName | Where-Object {$_.protocol -eq 'https'}
    if ($bindings -eq $null) {return}

    Get-MIMSSPRResetCertificateThumbprint
    $cert = Get-CertFromStore -Thumbprint $bindings.certificateHash
    Get-MIMSSPRResetCertificateSubject -Certificate $cert
    Get-MIMSSPRResetCertificateSANs -Certificate $cert
    Get-MIMSSPRResetCertificateFriendlyName -Certificate $cert
    Get-MIMSSPRResetCertificateExpiryDate -Certificate $cert
    Get-MIMSSPRResetCertificateIssuer -Certificate $cert
  }
  catch {
    return
  }
}