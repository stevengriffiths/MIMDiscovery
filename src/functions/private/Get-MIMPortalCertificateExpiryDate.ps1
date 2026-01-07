function Get-MIMPortalCertificateExpiryDate {
  [CmdletBinding()]
  param
  (
    [parameter(Mandatory = $true)]
    [System.Security.Cryptography.X509Certificates.X509Certificate2]
    $Certificate
  )

  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Portal'
      Property = 'CertExpiryDate'
      Value    = $Certificate.NotAfter
    }
  }
  catch {
    Write-Verbose 'An error occurred obtaining the MIM Portal certificate expiry date'
    return
  }
}