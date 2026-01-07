function Get-MIMPortalCertificateFriendlyName {
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
      Property = 'CertFriendlyName'
      Value    = $Certificate.FriendlyName
    }
  }
  catch {
    Write-Verbose 'An error occurred obtaining the MIM Portal certificate friendly name'
    return
  }
}