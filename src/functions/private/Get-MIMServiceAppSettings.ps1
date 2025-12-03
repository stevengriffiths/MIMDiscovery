function Get-MIMServiceAppSettings {
  try {
    $configFile = Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Services\FIMService -Name ExeConfigPath
    [xml]$config = Get-Content -Path $configFile
    ([xml]$config.OuterXml).SelectNodes("//appSettings/add") | ForEach-Object {
      [PSCustomObject]@{
        Host     = $env:COMPUTERNAME
        Role     = 'Service'
        Property = $_.key
        Value    = $_.value
      }
    }
  }
  catch {
    return
  }
}