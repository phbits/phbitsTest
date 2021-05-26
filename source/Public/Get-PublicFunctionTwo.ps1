Function Get-PublicFunctionTwo
{
	[CmdletBinding()]
	param()

	Write-Host 'Invoked Get-PublicFunctionTwo'

	Write-Host '>Invoked Get-PrivateFunction1'
	$null = Get-PrivateFunction1 -Input1 'Hello' -Input2 42

	Write-Host '>Get-PrivateFunctionTwo'
	$null = Get-PrivateFunctionTwo

} # End Function Get-PublicFunctionTwo