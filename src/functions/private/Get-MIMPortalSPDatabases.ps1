function Get-MIMPortalSPDatabases {
  [CmdletBinding()]
  param
  (
    [parameter(Mandatory = $true)]
    [Microsoft.SharePoint.Administration.SPWebApplication]
    $Application
  )

  try {
    if ($null -eq (Get-Module -ListAvailable -Name SharePointServer)) {Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue}

    $contentDB = $Application.ContentDatabases.Server + '|' + $Application.ContentDatabases.Name

    $config = Get-SPDatabase | `
      Where-Object {$_.TypeName -eq 'Configuration Database'} | `
      Select-Object -First 1
    $configDB = $config.NormalizedDataSource + '|' + $config.Name

    $adminApp = Get-SPWebApplication -IncludeCentralAdministration | `
      Where-Object {$_.IsAdministrationWebApplication -eq $true}
    $adminDB = $adminApp.ContentDatabases.Server + '|' + $adminApp.ContentDatabases.Name

    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Portal'
      Property = 'SharePoint databases'
      Value    = $contentDB + ', ' + $configDB + ', ' + $adminDB
    }
  }
  catch {
    return
  }
  finally {
    Remove-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
  }
}