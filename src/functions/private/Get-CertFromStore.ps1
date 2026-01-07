function Get-CertFromStore {
  [CmdletBinding()]
  param
  (
    [parameter(Mandatory = $true)]
    [string]
    $Thumbprint,

    [parameter(Mandatory = $false)]
    [string]
    $StoreName = 'My',

    [parameter(Mandatory = $false)]
    [string]
    $StoreLocation = 'LocalMachine'
  )
  try {
    $tp = ($Thumbprint -replace '\s', '').ToUpperInvariant()
    $store = New-Object System.Security.Cryptography.X509Certificates.X509Store($StoreName, $StoreLocation)
    try {
      $store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadOnly)
      $cert = $store.Certificates.Where({($_.Thumbprint -replace '\s', '').ToUpperInvariant() -eq $tp})
      $cert
    }
    catch {
      throw $_
    }
    finally {
      $store.Close()
    }
  }
  catch {
    Write-Verbose 'An error occurred obtaining the certificate from the store'
    return
  }
}