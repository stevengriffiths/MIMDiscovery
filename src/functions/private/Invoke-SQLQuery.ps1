function Invoke-SQLQuery {
  [CmdletBinding()]
  param
  (
    [parameter(Mandatory = $true)]
    [string]
    $DBServer,
    
    [parameter(Mandatory = $true)]
    [string]
    $Database,

    [parameter(Mandatory = $true)]
    [string]
    $SQL,

    [parameter(Mandatory = $false)]
    [int16]
    $ConnectionTimeoutSecs = 15,

    [parameter(Mandatory = $false)]
    [int16]
    $CommandTimeoutSecs = 30
  )

  try {
    $connectionString = "Server={0};Database={1};Integrated Security=True;Timeout={2}" -f $DBServer, $Database, $ConnectionTimeoutSecs
    $connection = New-Object System.Data.SqlClient.SqlConnection($connectionString)
    $connection.Open()
    $command = New-Object System.Data.SqlClient.SqlCommand($SQL, $connection)
    $command.CommandTimeout = $CommandTimeoutSecs
    $adapter = New-Object System.Data.SqlClient.SqlDataAdapter $command
    $dataset = New-Object System.Data.DataSet
    $adapter.Fill($dataSet) | Out-Null
    if ($null -ne $dataset.Tables[0]) {
      $dataset.Tables[0]
    }
    else {
      New-Object System.Collections.ArrayList
    }
  }
  catch {
    throw $_
  }
  finally {
    if ($connection.State -eq 'Open') {
      $connection.Close()
    }
  }
}