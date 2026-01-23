function Get-MIMSSPRResetCertificateExpiryDate {
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
      Property = 'CertExpiryDate'
      Value    = $Certificate.NotAfter
    }
  }
  catch {
    Write-Verbose 'An error occurred obtaining the SSPR Reset Site certificate expiry date'
    return
  }
}