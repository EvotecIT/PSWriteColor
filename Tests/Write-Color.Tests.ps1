param(
    [string] $ModulePath = (Join-Path $PSScriptRoot '../PSWriteColor.psd1')
)

BeforeAll {
    Get-Module PSWriteColor | Remove-Module -Force
    Import-Module $ModulePath -Force
}

Describe 'Write-Color output contract' {
    It 'exports only the command and its British spelling alias' {
        $Module = Get-Module PSWriteColor
        @($Module.ExportedFunctions.Keys) | Should -Be @('Write-Color')
        @($Module.ExportedAliases.Keys) | Should -Be @('Write-Colour')
        $Records = @(Write-Colour 'alias' -NoNewLine 6>&1)
        ($Records.MessageData.Message -join '') | Should -BeExactly 'alias'
    }

    It 'writes to the information stream without returning success objects' {
        $Output = @(Write-Color 'one', 'two' -InformationAction Ignore)
        $Output.Count | Should -Be 0
    }

    It 'uses the first color for remaining segments rather than cycling' {
        $Records = @(Write-Color a,b,c,d -Color Red,Green -BackgroundColor Black,Blue 6>&1)
        @($Records[0..3].MessageData.ForegroundColor) | Should -Be @('Red','Green','Red','Red')
        @($Records[0..3].MessageData.BackgroundColor) | Should -Be @('Black','Blue','Black','Black')
    }

    It 'handles null and absent text under strict mode' {
        $Records = @(& (Get-Module PSWriteColor) {
            Set-StrictMode -Version Latest
            try {
                Write-Color -Text $null -NoNewLine
                Write-Color -NoNewLine
                Write-Color -Text @('a', $null, 'b') -NoNewLine
            } finally {
                Set-StrictMode -Off
            }
        } 6>&1)
        ($Records.MessageData.Message -join '') | Should -BeExactly 'ab'
    }

    It 'rejects empty foreground colors before writing any text' {
        foreach ($Colors in @(@{ Value = $null }, @{ Value = @() })) {
            { Write-Color 'abc' -Color $Colors.Value -ErrorAction Stop } | Should -Throw '*Color must contain at least one*'
        }
    }

    It 'rejects mismatched colors before writing any text' {
        { Write-Color 'abc' -Color Red,Green -BackgroundColor Blue -ErrorAction Stop } | Should -Throw '*count*match*'
    }

    It 'rejects negative formatting counts' {
        foreach ($Name in 'StartTab','StartSpaces','LinesBefore','LinesAfter') {
            $Parameters = @{ Text = 'abc' }
            $Parameters[$Name] = -1
            { Write-Color @Parameters } | Should -Throw
        }
    }
}

Describe 'Write-Color logging contract' {
    It 'uses a literal log filename without touching a wildcard match' {
        $LiteralLog = Join-Path $TestDrive 'report[1].log'
        $OtherLog = Join-Path $TestDrive 'report1.log'
        Set-Content -LiteralPath $OtherLog -Value 'untouched'
        Write-Color 'one', 'two' -NoConsoleOutput -LogFile $LiteralLog -LogTime $false
        Get-Content -LiteralPath $LiteralLog | Should -BeExactly 'onetwo'
        Get-Content -LiteralPath $OtherLog | Should -BeExactly 'untouched'
    }

    It 'appends separate log entries regardless of console NoNewLine' {
        $Log = Join-Path $TestDrive 'append.log'
        Write-Color 'one' -NoConsoleOutput -NoNewLine -LogFile $Log -LogTime $false
        Write-Color 'two' -NoConsoleOutput -NoNewLine -LogFile $Log -LogTime $false
        @(Get-Content -LiteralPath $Log) | Should -Be @('one', 'two')
    }

    It 'honors InformationAction Ignore while retaining logging' {
        $Log = Join-Path $TestDrive 'information.log'
        $Output = @(Write-Color 'abc' -PadLeft 10 -LinesBefore 1 -LinesAfter 1 -InformationAction Ignore -LogFile $Log -LogTime $false 6>&1)
        $Output.Count | Should -Be 0
        Get-Content -LiteralPath $Log | Should -BeExactly 'abc'
    }

    It 'writes Unicode text in the default log encoding' {
        $Log = Join-Path $TestDrive 'unicode.log'
        $Text = 'Z' + [char]0x00F3 + [char]0x0142 + [char]0x0107
        Write-Color $Text -NoConsoleOutput -LogFile $Log -LogTime $false
        $Bytes = [IO.File]::ReadAllBytes($Log)
        @($Bytes[0..1]) | Should -Be @(255,254)
        [IO.File]::ReadAllText($Log) | Should -BeExactly ($Text + [Environment]::NewLine)
    }

    It 'uses the custom timestamp format in log entries' {
        $Log = Join-Path $TestDrive 'time.log'
        Write-Color 'abc' -NoConsoleOutput -LogFile $Log -DateTimeFormat "'time'"
        Get-Content -LiteralPath $Log | Should -BeExactly '[time] abc'
    }

    It 'logs under WhatIfPreference and with console output suppressed' {
        $Log = Join-Path $TestDrive 'whatif.log'
        $WhatIfPreference = $true
        Write-Color 'abc' -NoConsoleOutput -LogFile $Log -LogTime $false
        Get-Content -LiteralPath $Log | Should -BeExactly 'abc'
    }

    It 'preserves warning-only failure with a bounded attempt count' {
        $Log = Join-Path $TestDrive 'missing/file.log'
        $Warnings = @(Write-Color 'abc' -NoConsoleOutput -LogFile $Log -LogRetry 2 3>&1)
        $Warnings.Count | Should -Be 2
        $Warnings[0].ToString() | Should -BeLike '*Retrying*1/2*'
        $Warnings[1].ToString() | Should -BeLike '*Tried*2/2*'
        $Warnings[1].ToString() | Should -Not -BeLike '*Retrying*'
    }

    It 'rejects a zero or negative attempt count' {
        foreach ($Attempts in 0,-1) {
            { Write-Color 'abc' -NoConsoleOutput -LogRetry $Attempts } | Should -Throw
        }
    }

    It 'retries a transient file failure and stops immediately after success' {
        InModuleScope PSWriteColor {
            $script:LogAttempts = 0
            Mock Out-File -RemoveParameterType Encoding {
                $script:LogAttempts++
                if ($script:LogAttempts -eq 1) { throw [IO.IOException]::new('Temporary sharing violation') }
            }
            $Warnings = @(Write-Color 'abc' -NoConsoleOutput -LogFile 'transient.log' -LogRetry 3 3>&1)
            $Warnings.Count | Should -Be 1 -Because ($Warnings -join ' | ')
            Should -Invoke Out-File -Times 2 -Exactly
        }
    }
}

Describe 'Write-Color horizontal centering' {
    It 'centers using the visible window width for <Width> columns and <Text> text' -TestCases @(
        @{ Width = 10; Text = 'abc'; Spaces = 3 }
        @{ Width = 9; Text = 'abcd'; Spaces = 2 }
        @{ Width = 8; Text = 'abcd'; Spaces = 2 }
        @{ Width = 2; Text = 'abc'; Spaces = 0 }
    ) {
        param($Width, $Text, $Spaces)
        InModuleScope PSWriteColor -Parameters @{ Width = $Width; Text = $Text; Spaces = $Spaces } {
            Mock Get-Host { [pscustomobject]@{ UI = [pscustomobject]@{ RawUI = [pscustomobject]@{ WindowSize = @{ Width = $Width }; BufferSize = @{ Width = 200 } } } } }
            $Records = @(Write-Color $Text -HorizontalCenter -NoNewLine 6>&1)
            ($Records.MessageData.Message -join '') | Should -BeExactly ((' ' * $Spaces) + $Text)
        }
    }

    It 'still writes and logs when a host cannot provide RawUI dimensions' {
        $Log = Join-Path $TestDrive 'headless.log'
        InModuleScope PSWriteColor -Parameters @{ Log = $Log } {
            Mock Get-Host { throw [NotSupportedException]::new('No RawUI in this host') }
            $Records = @(Write-Color 'abc' -HorizontalCenter -NoNewLine -LogFile $Log -LogTime $false 6>&1)
            ($Records.MessageData.Message -join '') | Should -BeExactly 'abc'
            Get-Content -LiteralPath $Log | Should -BeExactly 'abc'
        }
    }
}
