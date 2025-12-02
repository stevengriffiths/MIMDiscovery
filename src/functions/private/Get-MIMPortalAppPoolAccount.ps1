function Get-MIMAppPoolAccount {
  [CmdletBinding()]
  param
  (
    [parameter(Mandatory = $true)]
    [Microsoft.SharePoint.Administration.SPWebApplication]
    $Application
  )

  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Portal'
      Property = 'Application pool account'
      Value    = $Application.ApplicationPool.Username
    }
  }
  catch {
    return
  }
}
