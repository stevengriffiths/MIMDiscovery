function Get-MIMServiceInstallAccount {
  try {
    Add-PSSnapin FIMAutomation
    $obj = Export-FIMConfig -CustomConfig "/Person[ObjectID='7fb2b853-24f0-4498-9534-4e10589723c4']" -OnlyBaseResources

    $domain = (($obj.ResourceManagementObject.ResourceManagementAttributes | Where-Object {$_.AttributeName -eq 'Domain'}).Value)
    $user = (($obj.ResourceManagementObject.ResourceManagementAttributes | Where-Object {$_.AttributeName -eq 'AccountName'}).Value)

    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Service'
      Property = 'Install account'
      Value    = $domain + '\' + $user
    }
  }
  catch {
    return
  }
  finally {
    Remove-PSSnapin FIMAutomation
  }
}