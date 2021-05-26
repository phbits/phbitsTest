@{

    RootModule = 'phbitsTest.psm1'
    
    ModuleVersion = '0.0.1'
    
    GUID = 'f8306d59-0a5f-4ae8-af7d-0bb6c4495649'
    
    Author = 'phbits'
    
    CompanyName = 'phbits'
    
    Copyright = '(c) 2021 phbits. All rights reserved.'
    
    Description = 'phbits Test Module Description'
    
    PowerShellVersion = '5.1'
    
    FunctionsToExport = 'Get-PublicFunction1','Get-PublicFunctionTwo'
    
    PrivateData = @{
    
        PSData = @{
    
            Prerelease = ''
    
            Tags = 'Test','DoNotUse'
    
            LicenseUri = 'https://github.com/phbits/phbitsTest/blob/main/LICENSE'
    
            ProjectUri = 'https://github.com/phbits/phbitsTest'
    
            ReleaseNotes = ''
        } # End of PSData hashtable    
    } # End of PrivateData hashtable
}
