function Get-MIMSyncADMAAccount {
  try {
    Add-Type -Path ((Get-MIMSyncInstallPath).Value + 'UIShell\PropertySheetBase.dll')
    $ws =  [Microsoft.DirectoryServices.MetadirectoryServices.UI.WebServices.MMSWebService]::new()
    $mas = Get-WmiObject -Namespace "root\MicrosoftIdentityIntegrationServer" -Class MIIS_ManagementAgent
    $mas | Where-Object { $_.Type -eq 'Active Directory' } | ForEach-Object {
      [xml]$x = $ws.ExportManagementAgent($_.Name, $true, $false, $(Get-Date -Format "yyyy-mm-dd HH:mm:ss"))
	  
      [PSCustomObject]@{
        Host     = $env:COMPUTERNAME
        Role     = 'Sync'
        Property = '{0} account' -f $_.Name
        Value    = ( $x.SelectSingleNode("//adma-configuration").'forest-login-domain' + '\' + $x.SelectSingleNode("//adma-configuration").'forest-login-user')
      }
    }
  }
  catch {
    return
  }
}