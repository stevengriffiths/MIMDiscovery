function Get-MIMServiceSPNs {
    try {
    $serviceAccount = (Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Services\FIMService -Name ObjectName) -replace '^[^\\]+\\', ''
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Service'
      Property = 'SPN'
      Value    = ((Get-ADObject -LDAPFilter "(&(objectClass=user)(sAMAccountName=$serviceAccount))" -Properties servicePrincipalName).'servicePrincipalName' -join ',')
    }
  }
  catch {
    return
  }
}