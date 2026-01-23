Set-ResourceManagementClient -BaseAddress http://localhost:5725

$mprList = @(
  'Anonymous users can reset their password',
  'Password reset users can read password reset objects',
  'Password Reset Users can update the lockout attributes of themselves',
  'User management: Users can read attributes of their own',
  'General: Users can read non-administrative configuration resources',
  'Administration: Administrators can read and update Users'
 )
 
 $mprList | ForEach-Object {
  $mpr = Search-Resources -XPath "/ManagementPolicyRule[DisplayName='$_']" -ExpectedObjectType ManagementPolicyRule
  [pscustomobject]@{
	MPR = $mpr.DisplayName
	State = (@('Enabled', 'Disabled')[$mpr.Disabled -eq $true])
  }
}
	