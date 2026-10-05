param(
    [string] $ModulePath = (Join-Path $PSScriptRoot '../PSWriteColor.psd1')
)

BeforeAll {
    Get-Module PSWriteColor | Remove-Module -Force
    Import-Module $ModulePath -Force
}

Describe 'Write-Color message streams' {
    It 'emits a complete verbose record without success output' {
        $records = @(Write-Color 'one', 'two' -OutputStream Verbose -Verbose 4>&1)
        $records.Count | Should -Be 1
        $records[0] | Should -BeOfType ([System.Management.Automation.VerboseRecord])
        $records[0].Message | Should -BeExactly 'onetwo'
        @(Write-Color 'hidden' -OutputStream Verbose -Verbose:$false 4>&1).Count | Should -Be 0
    }

    It 'emits a complete tagged information record and honors suppression' {
        $records = @(Write-Color 'one', 'two' -OutputStream Information -InformationAction Continue 6>&1)
        $records.Count | Should -Be 1
        $records[0] | Should -BeOfType ([System.Management.Automation.InformationRecord])
        $records[0].MessageData | Should -BeExactly 'onetwo'
        $records[0].Tags | Should -Contain 'WriteColor'
        @(Write-Color 'hidden' -OutputStream Information -InformationAction Ignore 6>&1).Count | Should -Be 0
    }

    It 'keeps file logging when the selected stream is suppressed' -ForEach @(
        @{ Stream = 'Verbose' }, @{ Stream = 'Information' }
    ) {
        $log = Join-Path $TestDrive "$Stream.log"
        $records = @(Write-Color 'one', 'two' -OutputStream $Stream -NoConsoleOutput -Verbose -InformationAction Continue -LogFile $log -LogTime $false *>&1)
        $records.Count | Should -Be 0
        Get-Content -LiteralPath $log | Should -BeExactly 'onetwo'
    }

    It 'uses timestamps but ignores terminal layout for record streams' {
        $records = @(Write-Color 'text' -OutputStream Verbose -Verbose -ShowTime -DateTimeFormat "'time'" -StartTab 2 -StartSpaces 2 -PadRight 20 -LinesBefore 2 -LinesAfter 2 -HorizontalCenter -NoNewLine 4>&1)
        $records.Count | Should -Be 1
        $records[0].Message | Should -BeExactly '[time] text'
    }

    It 'does not let information suppression silence the verbose stream' {
        $records = @(Write-Color 'text' -OutputStream Verbose -Verbose -InformationAction Ignore 4>&1)
        $records.Count | Should -Be 1
        $records[0].Message | Should -BeExactly 'text'
    }
}
