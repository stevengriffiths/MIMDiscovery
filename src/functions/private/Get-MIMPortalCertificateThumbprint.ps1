function Get-MIMPortalCertificateThumbprint {
  [CmdletBinding()]
  param
  (
    [parameter(Mandatory = $true)]
    [Microsoft.IIs.PowerShell.Framework.ConfigurationElement]
    $Bindings
  )

  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Portal'
      Property = 'CertThumbprint'
      Value    = $Bindings.certificateHash
    }
  }
  catch {
    Write-Verbose 'An error occurred obtaining the certificate thumbprint'
    return
  }
}