function Get-MIMPortalCertificateDetails {
  [CmdletBinding()]
  param
  (
    [parameter(Mandatory = $true)]
    [Microsoft.SharePoint.Administration.SPWebApplication]
    $Application
  )

  try {
    $b = Get-WebBinding -Name $Application.Name -Protocol 'https'
    if ($null -eq $b) {return}

    Get-MIMPortalCertificateThumbprint -Bindings $b
    $cert = Get-CertFromStore -Thumbprint $b.certificateHash
    Get-MIMPortalCertificateSubject -Certificate $cert
    Get-MIMPortalCertificateSANs -Certificate $cert
    Get-MIMPortalCertificateFriendlyName -Certificate $cert
    Get-MIMPortalCertificateExpiryDate -Certificate $cert
    Get-MIMPortalCertificateIssuer -Certificate $cert
  }
  catch {
    throw $_
  }
}