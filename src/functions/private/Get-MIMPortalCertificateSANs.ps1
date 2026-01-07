function Get-MIMPortalCertificateSANs {
  [CmdletBinding()]
  param
  (
    [parameter(Mandatory = $true)]
    [System.Security.Cryptography.X509Certificates.X509Certificate2]
    $Certificate
  )

  try {
    $sanOid = "2.5.29.17"
    $sanExt = $Certificate.Extensions.Where({ $_.Oid.Value -eq $sanOid })
    if (-not $sanExt) { return @() }

    $formatted = (New-Object System.Security.Cryptography.AsnEncodedData($sanExt.Oid, $sanExt.RawData)).Format($true)
    $sanItems = $formatted -split ',\s*' | ForEach-Object {
      ($_ -replace '^\s*', '') -replace '\s+$', ''
    }
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Portal'
      Property = 'CertSANs'
      Value    = ($sanItems -replace '\r\n', ',')
    }
  }
  catch {
    Write-Verbose 'An error occurred obtaining the MIM Portal certificate SANs'
    return
  }
}