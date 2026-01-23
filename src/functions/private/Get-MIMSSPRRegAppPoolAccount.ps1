function Get-MIMSSPRRegAppPoolAccount {
  try {
    $siteName = (Get-MIMSSPRRegSiteName).Value
    $app = Get-Website -Name $siteName
    $user = (Get-Item "IIS:\AppPools\$($app.applicationPool)").processModel.userName

    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'SSPRReg'
      Property = 'Application pool account'
      Value    = $user
    }
  }
  catch {
    return
  }
}