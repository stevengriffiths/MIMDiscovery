function Get-MIMServiceDelegation {
  try {
    $serviceAccount = (Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Services\FIMService -Name ObjectName) -replace '^[^\\]+\\', ''
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Service'
      Property = 'Delegation'
      Value    = ((Get-ADObject -LDAPFilter "(&(objectClass=user)(sAMAccountName=$serviceAccount))" -Properties msDS-AllowedToDelegateTo).'msDS-AllowedToDelegateTo' -join ',')
    }
  }
  catch {
    return
  }
}