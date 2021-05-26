Function Get-PrivateFunction1
{
	[CmdletBinding()]
	param(
		[System.String]
		$Input1
		,
		[System.Int32]
		$Input2
	)

	Write-Host ' * Invoked Get-PrivateFunction1 *'
	Write-Host "     `$Input1 = $Input1"
	Write-Host "     `$Input2 = $Input2"

} # End Function Get-PrivateFunction1