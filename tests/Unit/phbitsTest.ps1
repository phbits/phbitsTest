$here = Split-Path -Parent $MyInvocation.MyCommand.Path

# Convert-path required for PS7 or Join-Path fails
$ProjectPath = "$here\..\.." | Convert-Path
$ProjectName = (Get-ChildItem $ProjectPath\*\*.psd1 | Where-Object {
    ($_.Directory.Name -match 'source|src' -or $_.Directory.Name -eq $_.BaseName) -and
    $(try { Test-ModuleManifest $_.FullName -ErrorAction Stop }catch{$false}) }
).BaseName

$buildModuleFolder = Join-Path $ProjectPath -ChildPath "output\$ProjectName" -Resolve

$builtManifest = Get-ChildItem $buildModuleFolder -File `
                        -Filter "$ProjectName.psd1" -Recurse `
                        -ErrorAction SilentlyContinue

$manifestData = Import-PowerShellDataFile $builtManifest.FullName

$rootModule = Join-Path $builtManifest.Directory -ChildPath $manifestData.RootModule -Resolve

# Read the built RootModule into memory to test private and public functions.
# This is a 'dot sourcing' technique common to PowerShell.
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_scripts#script-scope-and-dot-sourcing
$ExecutionContext.InvokeCommand.InvokeScript(
    $false,
    (
        [ScriptBlock]::Create(
            [System.IO.File]::ReadAllText(
                $rootModule,
                [System.Text.Encoding]::UTF8
            )
        )
    ),
    $null,
    $null
)

# Define test cases. Function parameters will be checked to 
# ensure they exist and are the right type.
$paramsGetPrivateFunction1 = @(
	@{ 'Name' = 'Input1'; 'Type' = [System.String]; }
	@{ 'Name' = 'Input2'; 'Type' = [System.Int32];  }
)

$paramsGetPublicFunction = @(
	@{ 'Name' = 'Input1';            'Type' = [System.String];                                }
	@{ 'Name' = 'Input2';            'Type' = [System.Int32];                                 }
	@{ 'Name' = 'SwitchedParameter'; 'Type' = [System.Management.Automation.SwitchParameter]; }
)

Describe 'Get-PrivateFunction1' {
    Context 'Test Function Parameters' {
        BeforeAll {
            $functionParams = Get-Command -Name Get-PrivateFunction1
        }
        It "Should have parameter: <Name>." -TestCases $paramsGetPrivateFunction1 {
            param ($Name,$Type)

            $functionParams.Parameters.ContainsKey($Name) | Should -Be $true
        }
        It "Parameter '<Name>' should be type <Type>." -TestCases $paramsGetPrivateFunction1 {
            param ($Name, $Type)

            $functionParams.Parameters[$Name].ParameterType -eq $Type | Should -Be $true
        }
    }
}

Describe 'Get-PublicFunction' {
    Context 'Test Function Parameters' {
        BeforeAll {
            $functionParams = Get-Command -Name Get-PublicFunction
        }
        It "Should have parameter: <Name>." -TestCases $paramsGetPublicFunction {
            param ($Name)

            $functionParams.Parameters.ContainsKey($Name) | Should -Be $true
        }
        It "Parameter '<Name>' should be type <Type>." -TestCases $paramsGetPublicFunction {
            param ($Name, $Type)

            $functionParams.Parameters[$Name].ParameterType -eq $Type | Should -Be $true
        }
    }
}
