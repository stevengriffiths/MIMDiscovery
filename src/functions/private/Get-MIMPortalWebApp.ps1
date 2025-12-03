function Get-MIMPortalWebApp {
  try {
    $webApp = $null
    $url = Get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\Microsoft\Forefront Identity Manager\2010\Portal' -Name BaseSiteCollectionURL -ErrorAction Stop
    if ($url -match '^(?:https?:\/\/)?([^\/:]+)') {
      $fqdn = $Matches[1]
      Add-PSSnapin Microsoft.SharePoint.PowerShell
      $name = (Get-SPWebApplication | Where-Object { $_.Url -match $fqdn }).DisplayName
      $webApp = Get-SPWebApplication -Identity $name
    }
  }
  catch {
    throw $_
    return
  }
  finally {
    Remove-PSSnapin -Name Microsoft.SharePoint.PowerShell
    $webApp
  }
}