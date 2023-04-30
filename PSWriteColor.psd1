@{
    AliasesToExport      = 'Write-Colour'
    Author               = 'Przemyslaw Klys'
    CmdletsToExport      = @()
    CompanyName          = 'Evotec'
    CompatiblePSEditions = @('Desktop', 'Core')
    Copyright            = '(c) 2011 - 2023 Przemyslaw Klys @ Evotec. All rights reserved.'
    Description          = 'Write-Color is a wrapper around Write-Host allowing you to create nice looking scripts, with colorized output. It provides easy manipulation of colors, logging output to file (log) and nice formatting options out of the box.'
    FunctionsToExport    = 'Write-Color'
    GUID                 = '0b0ba5c5-ec85-4c2b-a718-874e55a8bc3f'
    ModuleVersion        = '1.0.1'
    PowerShellVersion    = '5.1'
    PrivateData          = @{
        PSData = @{
            Tags       = @('Write-Host', 'Color', 'Colour', 'Terminal', 'Console', 'Logging', 'Prompt', 'Write-Color', 'Windows', 'MacOS', 'Linux')
            IconUri    = 'https://evotec.xyz/wp-content/uploads/2018/10/PSWriteColor.png'
            ProjectUri = 'https://github.com/EvotecIT/PSWriteColor'
        }
    }
    RootModule           = 'PSWriteColor.psm1'
}