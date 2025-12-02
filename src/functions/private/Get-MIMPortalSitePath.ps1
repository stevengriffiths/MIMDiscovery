function Get-MIMPortalSitePath {
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
      Property = 'Site path'
      Value    = $Application.IisSettings.Values.Path.FullName
    }
  }
  catch {
    return
  }
}