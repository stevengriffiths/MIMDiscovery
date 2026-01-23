function Get-MIMSSPRResetUrl {
  try {
    $urlList = [System.Collections.ArrayList]::new()
    $siteName = (Get-MIMSSPRResetSiteName).Value
    $bindings = Get-WebBinding -Name $siteName
    $bindings | ForEach-Object {
      $protocol = $_.protocol
      $urlParts = $_.bindingInformation.Split(':')
      $url = '{0}://{1}:{2}' -f $protocol, $urlParts[2], $urlParts[1]
      $urlList.Add($url) | Out-Null
    }

    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'SSPRReset'
      Property = 'URL'
      Value    = ($urlList -join ' | ')
    }
  }
  catch {
    return
  }
}