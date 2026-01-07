function Get-MIMPortalCertificateSubject {
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
      Property = 'CertSubject'
      Value    = $Certificate.Subject
    }
  }
  catch {
    Write-Verbose 'An error occurred obtaining the MIM Portal certificate subject name'
    return
  }
}