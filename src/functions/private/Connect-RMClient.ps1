function Connect-RMClient {
  try {
    $configFile = ((Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Services\FIMService -Name ImagePath) -replace '"','') + '.config'
    [xml]$config = Get-Content -Path $configFile
    $baseAddress = ([xml]($config.OuterXml)).SelectNodes("//resourceManagementClient").resourceManagementServiceBaseAddress
    if ($baseAddress -match '^(?:https?:\/\/)?([^\/:]+)') {
      $rmclient = 'http://' + $Matches[1] + ':5725'
      Set-ResourceManagementClient -BaseAddress $rmclient
    }
  }
  catch {
    throw $_
  }
}