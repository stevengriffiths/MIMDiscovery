function Get-MIMSSPRRegCertificateThumbprint {
  try {
    $siteName = (Get-MIMSSPRRegSiteName).Value
    $bindings = Get-WebBinding -Name $siteName | Where-Object {$_.protocol -eq 'https'}
    if ($bindings -eq $null) {return}

    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'SSPRReg'
      Property = 'CertThumbprint'
      Value    = $bindings.certificateHash
    }
  }
  catch {
    return
  }
}