function Get-MIMSSPRRegSiteName {

  try {
    $installPath = (Get-MIMSSPRRegInstallPath).Value -replace '\\$',''
    $site = Get-Website | Where-Object {$_.physicalPath -eq $installPath}
    if ([string]::IsNullOrEmpty($site)) {return}

    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'SSPRReg'
      Property = 'Site name'
      Value    = $site.Name
    }
  }
  catch {
    return
  }
}