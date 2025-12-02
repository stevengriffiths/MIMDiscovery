function Get-MIMPortalSiteName {
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
      Property = 'Site name'
      Value    = $Application.DisplayName
    }
  }
  catch {
    return
  }
}