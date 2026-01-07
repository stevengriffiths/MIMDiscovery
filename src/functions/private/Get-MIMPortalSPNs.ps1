function Get-MIMPortalSPNs {
  [CmdletBinding()]
  param
  (
    [parameter(Mandatory = $true)]
    [Microsoft.SharePoint.Administration.SPWebApplication]
    $Application
  )

  try {
    $appPoolUser = $Application.ApplicationPool.Username -replace '^[^\\]+\\', ''
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Portal'
      Property = 'SPN'
      Value    = ((Get-ADObject -LDAPFilter "(&(objectClass=user)(sAMAccountName=$appPoolUser))" -Properties servicePrincipalName).'servicePrincipalName' -join ',')
    }
  }
  catch {
    return
  }
}