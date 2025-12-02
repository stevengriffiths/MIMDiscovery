function Get-MIMSyncGroups {

  try {
    $Server = Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Services\FIMSynchronizationService\Parameters -Name Server
    $Database = Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Services\FIMSynchronizationService\Parameters -Name DBName

    $connection = New-Object System.Data.SqlClient.SqlConnection -ArgumentList "Server=$Server;Database=$Database;Trusted_Connection=True;"
    $connection.Open()

    $command = New-Object System.Data.SqlClient.SqlCommand
    $command.Connection = $connection
    $command.CommandText = @"
SELECT
	administrators_sid,
	operators_sid,
	account_joiners_sid,
	browse_sid,
	passwordset_sid
FROM
	mms_server_configuration
WITH (NOLOCK) 
"@

    $dataset = New-Object System.Data.DataSet
    $dataAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
    $dataAdapter.SelectCommand = $command
    [void]($dataAdapter.Fill($dataset))

    $admins = $dataset.Tables[0].Rows[0].administrators_sid
    $ops = $dataset.Tables[0].Rows[0].operators_sid
    $joiners = $dataset.Tables[0].Rows[0].account_joiners_sid
    $browsers = $dataset.Tables[0].Rows[0].browse_sid
    $pwdSet = $dataset.Tables[0].Rows[0].passwordset_sid

    $translated = @()

    $sid = New-Object System.Security.Principal.SecurityIdentifier -ArgumentList $admins, 0
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Sync'
      Property = 'Administrators group'
      Value    = $sid.Translate([System.Security.Principal.NTAccount])
    }

    $sid = New-Object System.Security.Principal.SecurityIdentifier -ArgumentList $ops, 0
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Sync'
      Property = 'Operators group'
      Value    = $sid.Translate([System.Security.Principal.NTAccount])
    }

    $sid = New-Object System.Security.Principal.SecurityIdentifier -ArgumentList $joiners, 0
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Sync'
      Property = 'Joiners group'
      Value    = $sid.Translate([System.Security.Principal.NTAccount])
    }

    $sid = New-Object System.Security.Principal.SecurityIdentifier -ArgumentList $browsers, 0
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Sync'
      Property = 'Browsers group'
      Value    = $sid.Translate([System.Security.Principal.NTAccount])
    }

    $sid = New-Object System.Security.Principal.SecurityIdentifier -ArgumentList $pwdset, 0
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Sync'
      Property = 'PasswordSet group'
      Value    = $sid.Translate([System.Security.Principal.NTAccount])
    }
  }
  catch {

  }
  finally {
    $connection.Close()
  }
}