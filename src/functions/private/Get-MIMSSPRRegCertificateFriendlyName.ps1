function Get-MIMSSPRRegCertificateFriendlyName {
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
      Property = 'CertFriendlyName'
      Value    = $Certificate.FriendlyName
    }
  }
  catch {
    Write-Verbose 'An error occurred obtaining the certificate friendly name'
    return
  }
}