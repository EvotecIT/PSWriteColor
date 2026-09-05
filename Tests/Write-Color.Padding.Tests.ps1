BeforeAll {
    Import-Module (Join-Path $PSScriptRoot '../PSWriteColor.psd1') -Force

    function Get-ColorOutput {
        param([hashtable] $Parameters)
        $Records = @(Write-Color @Parameters 6>&1)
        $Builder = [System.Text.StringBuilder]::new()
        foreach ($Record in $Records) {
            [void]$Builder.Append($Record.MessageData.Message)
            if (-not $Record.MessageData.NoNewLine) {
                [void]$Builder.Append("`n")
            }
        }
        $Builder.ToString()
    }
}

Describe 'Write-Color fixed-width padding' {
    It 'pads the combined message for <Mode>' -TestCases @(
        @{ Mode = 'PadLeft'; Expected = '.....abc' }
        @{ Mode = 'PadCenter'; Expected = '..abc...' }
        @{ Mode = 'PadRight'; Expected = 'abc.....' }
    ) {
        param($Mode, $Expected)
        $Parameters = @{ Text = @('a', 'bc'); Color = @('Red', 'Green'); PadCharacter = '.'; NoNewLine = $true }
        $Parameters[$Mode] = 8
        Get-ColorOutput $Parameters | Should -BeExactly $Expected
    }

    It 'does not truncate text at width <Width>' -TestCases @(@{ Width = 2 }, @{ Width = 3 }) {
        param($Width)
        foreach ($Mode in 'PadLeft', 'PadCenter', 'PadRight') {
            $Parameters = @{ Text = 'abc'; NoNewLine = $true }
            $Parameters[$Mode] = $Width
            Get-ColorOutput $Parameters | Should -BeExactly 'abc'
        }
    }

    It 'preserves segment colors and uses the first colors for padding and blank rows' {
        $Records = @(Write-Color -Text 'a', 'bc' -Color Red, Green -BackgroundColor Black, Blue -PadCenter 8 -PadCharacter '.' -LinesBefore 1 -LinesAfter 1 6>&1)
        ($Records.MessageData.Message -join '') | Should -BeExactly "........`n..abc...........`n"
        $Records[2].MessageData.ForegroundColor | Should -Be 'Red'
        $Records[3].MessageData.ForegroundColor | Should -Be 'Green'
        $Records[3].MessageData.BackgroundColor | Should -Be 'Blue'
        foreach ($Index in 0, 1, 4, 6) {
            $Records[$Index].MessageData.ForegroundColor | Should -Be 'Red'
            $Records[$Index].MessageData.BackgroundColor | Should -Be 'Black'
        }
    }

    It 'preserves fallback colors when there are more text segments than colors' {
        $Records = @(Write-Color -Text 'a', 'b', 'c' -Color Yellow -BackgroundColor Black -PadRight 5 6>&1)
        foreach ($Index in 0, 1, 2, 3) {
            $Records[$Index].MessageData.ForegroundColor | Should -Be 'Yellow'
            $Records[$Index].MessageData.BackgroundColor | Should -Be 'Black'
        }
    }

    It 'pads empty text and supports the parameter aliases' {
        Get-ColorOutput @{ Text = ''; PL = 3; PadChar = '.'; NoNewLine = $true } | Should -BeExactly '...'
        Get-ColorOutput @{ PC = 3; PadChar = '.'; NoNewLine = $true } | Should -BeExactly '...'
        Get-ColorOutput @{ Text = 'a'; PR = 3; PadChar = '.' } | Should -BeExactly "a..`n"
    }

    It 'leaves input arrays and log content unchanged' {
        $Text = @('a', 'bc')
        $Log = Join-Path $TestDrive 'padding.log'
        Get-ColorOutput @{ Text = $Text; PadLeft = 8; LogFile = $Log; LogTime = $false } | Should -BeExactly "     abc`n"
        ($Text -join '|') | Should -BeExactly 'a|bc'
        Get-Content -LiteralPath $Log | Should -BeExactly 'abc'
    }

    It 'suppresses all console padding while still logging with NoConsoleOutput' {
        $Log = Join-Path $TestDrive 'hidden.log'
        Get-ColorOutput @{ Text = 'abc'; PadRight = 8; LinesBefore = 1; LinesAfter = 1; NoConsoleOutput = $true; LogFile = $Log; LogTime = $false } | Should -BeExactly ''
        Get-Content -LiteralPath $Log | Should -BeExactly 'abc'
    }

    It 'keeps indentation and timestamps outside the requested text width' {
        Get-ColorOutput @{ Text = 'abc'; PadLeft = 5; PadCharacter = '.'; StartTab = 1; StartSpaces = 2; ShowTime = $true; DateTimeFormat = "'time'" } | Should -BeExactly "`t  [time] ..abc`n"
    }

    It 'centers the padded width in the host buffer' {
        $Width = $Host.UI.RawUI.BufferSize.Width
        $Expected = 'a..'
        if ($Width -ge 3) {
            $Expected = (' ' * [Math]::Max(0, $Width / 2 - [Math]::Floor(3 / 2))) + $Expected
        }
        Get-ColorOutput @{ Text = 'a'; PadRight = 3; PadCharacter = '.'; HorizontalCenter = $true; NoNewLine = $true } | Should -BeExactly $Expected
    }

    It 'preserves existing unpadded output and blank rows' {
        Get-ColorOutput @{ Text = @('a', 'bc'); Color = @('Red', 'Green'); LinesBefore = 1; LinesAfter = 1 } | Should -BeExactly "`nabc`n`n"
    }

    It 'rejects ambiguous widths and invalid padding values before output' {
        { Write-Color abc -PadLeft 3 -PadRight 4 } | Should -Throw
        { Write-Color abc -PadCenter 3 -PadRight 4 } | Should -Throw
        { Write-Color abc -PadLeft 3 -PadCenter 4 } | Should -Throw
        foreach ($Mode in 'PadLeft', 'PadCenter', 'PadRight') {
            $Parameters = @{ Text = 'abc' }
            $Parameters[$Mode] = -1
            { Write-Color @Parameters } | Should -Throw
        }
        { Write-Color abc -PadRight 8 -PadCharacter 'ab' } | Should -Throw
        { Write-Color abc -PadRight 8 -PadCharacter '' } | Should -Throw
    }
}
