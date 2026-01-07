function Get-MIMPortalCertificateIssuer {
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
      Property = 'CertIssuer'
      Value    = $Certificate.Issuer
    }
  }
  catch {
    Write-Verbose 'An error occurred obtaining the MIM Portal certificate issuer'
    return
  }
}