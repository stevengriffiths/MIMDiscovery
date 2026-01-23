function Get-MIMSSPRRegCertificateExpiryDate {
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
      Role     = 'SSPRReg'
      Property = 'CertExpiryDate'
      Value    = $Certificate.NotAfter
    }
  }
  catch {
    Write-Verbose 'An error occurred obtaining the SSPR Registration Site certificate expiry date'
    return
  }
}