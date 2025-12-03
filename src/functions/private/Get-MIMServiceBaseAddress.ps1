function Get-MIMServiceBaseAddress {
  try {
    $configFile = Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Services\FIMService -Name ExeConfigPath
    [xml]$config = Get-Content -Path $configFile
    $baseAddress = ([xml]($config.OuterXml)).SelectNodes("//resourceManagementClient").resourceManagementServiceBaseAddress
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Service'
      Property = 'Base address'
      Value    = $baseAddress
    }
  }
  catch {
    return
  }
}