@{
    AliasesToExport      = 'Write-Colour'
    Author               = 'Przemyslaw Klys'
    CmdletsToExport      = @()
    CompanyName          = 'Evotec'
    CompatiblePSEditions = @('Desktop', 'Core')
    Copyright            = '(c) 2011 - 2021 Przemyslaw Klys @ Evotec. All rights reserved.'
    Description          = 'Write-Color is a wrapper around Write-Host allowing you to create nice looking scripts, with colorized output. It provides easy manipulation of colors, logging output to file (log) and nice formatting options out of the box.'
    FunctionsToExport    = 'Write-Color'
    GUID                 = '0b0ba5c5-ec85-4c2b-a718-874e55a8bc3f'
    ModuleVersion        = '0.87.3'
    PowerShellVersion    = '5.1'
    PrivateData          = @{
        PSData = @{
            Tags       = @('Write-Host', 'Color', 'Colour', 'Terminal', 'Console', 'Logging', 'Prompt', 'Write-Color', 'Windows', 'MacOS', 'Linux')
            ProjectUri = 'https://github.com/EvotecIT/PSWriteColor'
            IconUri    = 'https://evotec.xyz/wp-content/uploads/2018/10/PSWriteColor.png'
        }
    }
    RootModule           = 'PSWriteColor.psm1'
}