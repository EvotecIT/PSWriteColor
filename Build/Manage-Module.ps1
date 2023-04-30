Clear-Host
Import-Module C:\Support\GitHub\PSPublishModule\PSPublishModule.psd1 -Force

Build-Module -ModuleName 'PSWriteColor' {
    # Usual defaults as per standard module
    $Manifest = @{
        # Version number of this module.
        ModuleVersion        = '1.0.X'
        # Supported PSEditions
        CompatiblePSEditions = @('Desktop', 'Core')
        # ID used to uniquely identify this module
        GUID                 = '0b0ba5c5-ec85-4c2b-a718-874e55a8bc3f'
        # Author of this module
        Author               = 'Przemyslaw Klys'
        # Company or vendor of this module
        CompanyName          = 'Evotec'
        # Copyright statement for this module
        Copyright            = "(c) 2011 - $((Get-Date).Year) Przemyslaw Klys @ Evotec. All rights reserved."
        # Description of the functionality provided by this module
        Description          = 'Write-Color is a wrapper around Write-Host allowing you to create nice looking scripts, with colorized output. It provides easy manipulation of colors, logging output to file (log) and nice formatting options out of the box.'
        # Minimum version of the Windows PowerShell engine required by this module
        PowerShellVersion    = '5.1'
        # Tags applied to this module. These help with module discovery in online galleries.
        Tags                 = 'Write-Host', 'Color', 'Colour', 'Terminal', 'Console', 'Logging', 'Prompt', 'Write-Color', 'Windows', 'MacOS', 'Linux'
        # A URL to the main website for this project.
        ProjectUri           = 'https://github.com/EvotecIT/PSWriteColor'
        # A URL to an icon representing this module.
        IconUri              = 'https://evotec.xyz/wp-content/uploads/2018/10/PSWriteColor.png'
    }
    New-ConfigurationManifest @Manifest

    $ConfigurationFormat = [ordered] @{
        RemoveComments                              = $false

        PlaceOpenBraceEnable                        = $true
        PlaceOpenBraceOnSameLine                    = $true
        PlaceOpenBraceNewLineAfter                  = $true
        PlaceOpenBraceIgnoreOneLineBlock            = $false

        PlaceCloseBraceEnable                       = $true
        PlaceCloseBraceNewLineAfter                 = $true
        PlaceCloseBraceIgnoreOneLineBlock           = $false
        PlaceCloseBraceNoEmptyLineBefore            = $false

        UseConsistentIndentationEnable              = $true
        UseConsistentIndentationKind                = 'space'
        UseConsistentIndentationPipelineIndentation = 'IncreaseIndentationAfterEveryPipeline'
        UseConsistentIndentationIndentationSize     = 4

        UseConsistentWhitespaceEnable               = $true
        UseConsistentWhitespaceCheckInnerBrace      = $true
        UseConsistentWhitespaceCheckOpenBrace       = $true
        UseConsistentWhitespaceCheckOpenParen       = $true
        UseConsistentWhitespaceCheckOperator        = $true
        UseConsistentWhitespaceCheckPipe            = $true
        UseConsistentWhitespaceCheckSeparator       = $true

        AlignAssignmentStatementEnable              = $true
        AlignAssignmentStatementCheckHashtable      = $true

        UseCorrectCasingEnable                      = $true
    }
    # format PSD1 and PSM1 files when merging into a single file
    # enable formatting is not required as Configuration is provided
    New-ConfigurationFormat -ApplyTo 'OnMergePSM1', 'OnMergePSD1' @ConfigurationFormat -EnableFormatting
    # format PSD1 and PSM1 files within the module
    # enable formatting is required to make sure that formatting is applied (with default settings)
    New-ConfigurationFormat -ApplyTo 'DefaultPSD1', 'DefaultPSM1' -EnableFormatting
    # when creating PSD1 use special style without comments and with only required parameters
    New-ConfigurationImportModule -ImportSelf
    New-ConfigurationBuild -Enable:$true -SignModule -MergeModuleOnBuild -MergeFunctionsFromApprovedModules -CertificateThumbprint '36A8A2D0E227D81A2D3B60DCE0CFCF23BEFC343B'

    New-ConfigurationArtefact -Type Unpacked -Enable -Path "$PSScriptRoot\..\Artefacts"
    New-ConfigurationArtefact -Type Packed -Enable

    #New-ConfigurationPublish -Type PowerShellGallery -FilePath 'C:\Support\Important\PowerShellGalleryAPI.txt' -Enabled -Verbose
    #New-ConfigurationPublish -Type GitHub -FilePath 'C:\Support\Important\GitHubAPI.txt' -UserName 'EvotecIT' -Enabled
}