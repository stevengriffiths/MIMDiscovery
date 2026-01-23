function Get-MIMSSPRResetCertificateSubject {
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
      Property = 'CertSubject'
      Value    = $Certificate.Subject
    }
  }
  catch {
    Write-Verbose 'An error occurred obtaining the SSPR Reset Site certificate subject name'
    return
  }
}