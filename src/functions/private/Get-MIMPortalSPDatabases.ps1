function Get-MIMPortalSPDatabases {
  [CmdletBinding()]
  param
  (
    [parameter(Mandatory = $true)]
    [Microsoft.SharePoint.Administration.SPWebApplication]
    $Application
  )

  try {
    $contentDB = $Application.ContentDatabases.Server + '|' + $Application.ContentDatabases.Name 
    $centralSrv = ($Application.Farm.Servers | Where-Object {$_.Role -eq 'SingleServerFarm'}).Address
    $centralDB = $centralSrv + '|' + $Application.Farm.Name

    $adminApp = Get-SPWebApplication -IncludeCentralAdministration | `
      Where-Object {$_.IsAdministrationWebApplication -eq $true}
    $adminDB = $adminApp.ContentDatabases.Server + '|' + $adminApp.ContentDatabases.Name

    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Portal'
      Property = 'SharePoint databases'
      Value    = $contentDB + ',' + $centralDB + ',' + $adminDB
    }
  }
  catch {
    return
  }
}