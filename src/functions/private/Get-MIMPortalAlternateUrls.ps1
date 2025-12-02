function Get-MIMPortalAlternateUrls {
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
      Property = 'Alternate Urls'
      Value    = $Application.AlternateUrls.IncomingUrl -join ','
    }
  }
  catch {
    return
  }
}