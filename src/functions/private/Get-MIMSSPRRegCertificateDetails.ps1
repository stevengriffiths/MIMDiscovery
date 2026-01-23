function Get-MIMSSPRRegCertificateDetails {
  try {
    $siteName = (Get-MIMSSPRRegSiteName).Value
    $bindings = Get-WebBinding -Name $siteName | Where-Object {$_.protocol -eq 'https'}
    if ($bindings -eq $null) {return}

    Get-MIMSSPRRegCertificateThumbprint
    $cert = Get-CertFromStore -Thumbprint $bindings.certificateHash
    Get-MIMSSPRRegCertificateSubject -Certificate $cert
    Get-MIMSSPRRegCertificateSANs -Certificate $cert
    Get-MIMSSPRRegCertificateFriendlyName -Certificate $cert
    Get-MIMSSPRRegCertificateExpiryDate -Certificate $cert
    Get-MIMSSPRRegCertificateIssuer -Certificate $cert
  }
  catch {
    return
  }
}