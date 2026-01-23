function Get-MIMSSPRResetSiteName {

  try {
    $installPath = (Get-MIMSSPRResetInstallPath).Value -replace '\\$',''
    $site = Get-Website | Where-Object {$_.physicalPath -eq $installPath}
    if ([string]::IsNullOrEmpty($site)) {return}

    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'SSPRReset'
      Property = 'Site name'
      Value    = $site.Name
    }
  }
  catch {
    return
  }
}