Function Get-PublicFunction
{
	[CmdletBinding()]
	param(
		[System.String]
		$Input1
		,
		[System.Int32]
		$Input2
		,
		[Switch]
		$SwitchedParameter
	)

	Write-Host 'Invoked Get-PublicFunction'
	Write-Host "  `$Input1 = $Input1"
	Write-Host "  `$Input2 = $Input2"
	Write-Host "  `$SwitchedParameter = $SwitchedParameter"

} # End Function Get-PublicFunction