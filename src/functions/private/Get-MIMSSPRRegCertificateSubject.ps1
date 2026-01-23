function Get-MIMSSPRRegCertificateSubject {
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
      Property = 'CertSubject'
      Value    = $Certificate.Subject
    }
  }
  catch {
    Write-Verbose 'An error occurred obtaining the certificate subject name'
    return
  }
}