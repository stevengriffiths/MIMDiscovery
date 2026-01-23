function Get-MIMSSPRResetAppPoolAccount {
  try {
    $siteName = (Get-MIMSSPRResetSiteName).Value
    $app = Get-Website -Name $siteName
    $user = (Get-Item "IIS:\AppPools\$($app.applicationPool)").processModel.userName

    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'SSPRReset'
      Property = 'Application pool account'
      Value    = $user
    }
  }
  catch {
    return
  }
}