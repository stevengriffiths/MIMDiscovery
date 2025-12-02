function Connect-RMClient {
  try {
    Set-ResourceManagementClient -BaseAddress http://service5.litware.com:5725
  }
  catch {
    throw $_
  }
}