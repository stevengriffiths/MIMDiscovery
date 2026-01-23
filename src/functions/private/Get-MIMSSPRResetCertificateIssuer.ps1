function Get-MIMSSPRResetCertificateIssuer {
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
      Role     = 'SSPRReset'
      Property = 'CertIssuer'
      Value    = $Certificate.Issuer
    }
  }
  catch {
    Write-Verbose 'An error occurred obtaining the SSPR Reset Site certificate issuer'
    return
  }
}