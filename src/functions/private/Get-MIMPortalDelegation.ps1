function Get-MIMPortalDelegation {
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
      Property = 'Delegation'
      Value    = ((Get-ADObject -LDAPFilter "(&(objectClass=user)(sAMAccountName=$appPoolUser))" -Properties msDS-AllowedToDelegateTo).'msDS-AllowedToDelegateTo' -join ',')
    }
  }
  catch {
    return
  }
}