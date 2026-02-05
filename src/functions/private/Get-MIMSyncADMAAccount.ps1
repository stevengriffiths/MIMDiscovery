function Get-MIMSyncADMAAccount {
  try {
    $mas = Get-WmiObject -Namespace "root\MicrosoftIdentityIntegrationServer" -Class MIIS_ManagementAgent
    $imagePath = Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Services\FIMSynchronizationService -Name ImagePath
    $maexport = ($ImagePath -replace 'miiserver.exe', 'maexport.exe') -replace '"', ''
    $mas | Where-Object { $_.Type -eq 'Active Directory' } | ForEach-Object {
      $mafile = $env:Temp + '\MA-' + $_.Name + '.xml'
      & $maexport "$($_.Name)" "$mafile" | Out-Null
      [xml]$x = Get-Content -Path $mafile
	  
      [PSCustomObject]@{
        Host     = $env:COMPUTERNAME
        Role     = 'Sync'
        Property = '{0} account' -f $_.Name
        Value    = ( $x.SelectSingleNode("//adma-configuration").'forest-login-domain' + '\' + $x.SelectSingleNode("//adma-configuration").'forest-login-user')
      }
    }
  }
  catch {
    return
  }
  finally {
    if ($mafile) { Remove-Item -Path $mafile -Force -ErrorAction SilentlyContinue }
  }
}