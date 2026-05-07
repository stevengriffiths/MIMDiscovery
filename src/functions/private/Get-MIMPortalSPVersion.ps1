function Get-MIMPortalSPVersion {
  try {
    $psconfig = Get-SPPSConfigPath
    $version = (Get-Item -Path $psconfig).VersionInfo.ProductVersion
  }
  catch {
    $version = 'Unavailable'
  }
  finally {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Portal'
      Property = 'SharePoint version'
      Value    = $version
    }
  }
}