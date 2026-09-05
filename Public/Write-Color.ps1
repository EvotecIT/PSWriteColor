function Write-Color {
    <#
    .SYNOPSIS
    Write-Color is a wrapper around Write-Host delivering a lot of additional features for easier color options.

    .DESCRIPTION
    Write-Color is a wrapper around Write-Host delivering a lot of additional features for easier color options.

    It provides:
    - Easy manipulation of colors,
    - Logging output to file (log)
    - Nice formatting options out of the box.
    - Ability to use aliases for parameters

    .PARAMETER Text
    Text to display on screen and write to log file if specified.
    Accepts an array of strings.

    .PARAMETER Color
    Color of each text segment. Remaining segments use the first color when there are more strings than colors.
    Available colors are: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

    .PARAMETER BackGroundColor
    Background color of each text segment. When supplied, its count must match Color.
    Remaining segments use the first background color when there are more strings than colors.
    Available colors are: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

    .PARAMETER StartTab
    Number of tabs to add before text. Default is 0.

    .PARAMETER LinesBefore
    Number of empty lines before text. Default is 0.

    .PARAMETER LinesAfter
    Number of empty lines after text. Default is 0.

    .PARAMETER StartSpaces
    Number of spaces to add before text. Default is 0.

    .PARAMETER LogFile
    Literal path to the log file. If not specified no log file will be created.
    Appends joined text with a newline, regardless of NoNewLine. Parent directories must already exist.
    File-write failures produce warnings after up to LogRetry attempts.

    .PARAMETER DateTimeFormat
    Custom date and time format string. Default is yyyy-MM-dd HH:mm:ss

    .PARAMETER LogTime
    If set to $true it will add time to log file. Default is $true.

    .PARAMETER LogRetry
    Maximum number of file-write attempts, including the first attempt. Must be at least 1. Default is 2.

    .PARAMETER Encoding
    Encoding of the log file. Default is Unicode.

    .PARAMETER ShowTime
    Switch to add time to console output. Default is not set.

    .PARAMETER NoNewLine
    Switch to not add new line at the end of the output. Default is not set.

    .PARAMETER NoConsoleOutput
    Switch to not output to console. Default all output goes to console.

    .PARAMETER HorizontalCenter
    Centers single-line text, including its padding, in the visible host window. Odd extra space goes on the right.
    Indentation and timestamps are added after centering. If the host cannot report its window width, no centering spaces are added.

    .PARAMETER PadLeft
    Minimum combined text width, with padding before the first colored segment. Default is 0 (disabled).
    Width counts string characters, not terminal display cells; use single-line text without tabs or ANSI sequences.
    Text is never truncated. Indentation and timestamps are outside this width; log text is unchanged.
    Specify only one positive padding width per call.

    .PARAMETER PadCenter
    Minimum combined text width, with padding on both sides. An odd extra character goes on the right.

    .PARAMETER PadRight
    Minimum combined text width, with padding after the last colored segment.

    .PARAMETER PadCharacter
    Single character used for padding. Default is a space.
    Padding uses the first foreground/background colors. With padding enabled, LinesBefore and LinesAfter
    also fill the requested width with this character and these colors.

    .EXAMPLE
    Write-Color -Text "Red ", "Green ", "Yellow " -Color Red,Green,Yellow

    .EXAMPLE
    Write-Color -Text "This is text in Green ",
                      "followed by red ",
                      "and then we have Magenta... ",
                      "isn't it fun? ",
                      "Here goes DarkCyan" -Color Green,Red,Magenta,White,DarkCyan

    .EXAMPLE
    Write-Color -Text "This is text in Green ",
                      "followed by red ",
                      "and then we have Magenta... ",
                      "isn't it fun? ",
                      "Here goes DarkCyan" -Color Green,Red,Magenta,White,DarkCyan -StartTab 3 -LinesBefore 1 -LinesAfter 1

    .EXAMPLE
    Write-Color "1. ", "Option 1" -Color Yellow, Green
    Write-Color "2. ", "Option 2" -Color Yellow, Green
    Write-Color "3. ", "Option 3" -Color Yellow, Green
    Write-Color "4. ", "Option 4" -Color Yellow, Green
    Write-Color "9. ", "Press 9 to exit" -Color Yellow, Gray -LinesBefore 1

    .EXAMPLE
    $LogPath = Join-Path ([IO.Path]::GetTempPath()) 'PSWriteColor.log'
    Write-Color -LinesBefore 2 -Text "This little ","message is ", "written to log ", "file as well." `
                -Color Yellow, White, Green, Red, Red -LogFile $LogPath -TimeFormat "yyyy-MM-dd HH:mm:ss"
    Write-Color -Text "This can get ","handy if ", "want to display things, and log actions to file ", "at the same time." `
                -Color Yellow, White, Green, Red, Red -LogFile $LogPath

    .EXAMPLE
    Write-Color -T "My text", " is ", "all colorful" -C Yellow, Red, Green -B Green, Green, Yellow
    Write-Color -t "my text" -c yellow -b green
    Write-Color -text "my text" -c red

    .EXAMPLE
    $LogPath = Join-Path ([IO.Path]::GetTempPath()) 'PSWriteColor.log'
    Write-Color -Text "Testuję czy się ładnie zapisze, czy będą problemy" -Encoding unicode -LogFile $LogPath -Color Red -NoConsoleOutput

    .EXAMPLE
    Write-Color '1. ', 'Start backup' -Color Yellow, White -BackgroundColor Blue, Blue -PadRight 32 -LinesBefore 1
    Write-Color '9. ', 'Exit' -Color Yellow, White -BackgroundColor Blue, Blue -PadRight 32 -LinesAfter 1
    Write-Color ' MENU ' -PadCenter 32 -PadCharacter '-' -Color Cyan

    .NOTES
    Understanding Custom date and time format strings: https://learn.microsoft.com/en-us/dotnet/standard/base-types/custom-date-and-time-format-strings
    Project support: https://github.com/EvotecIT/PSWriteColor
    Original idea: Josh (https://stackoverflow.com/users/81769/josh)

    #>
    [alias('Write-Colour')]
    [CmdletBinding()]
    param (
        [alias ('T')] [String[]]$Text,
        [alias ('C', 'ForegroundColor', 'FGC')] [ConsoleColor[]]$Color = [ConsoleColor]::White,
        [alias ('B', 'BGC')] [ConsoleColor[]]$BackGroundColor = $null,
        [alias ('Indent')][ValidateRange(0, [int]::MaxValue)][int] $StartTab = 0,
        [ValidateRange(0, [int]::MaxValue)][int] $LinesBefore = 0,
        [ValidateRange(0, [int]::MaxValue)][int] $LinesAfter = 0,
        [ValidateRange(0, [int]::MaxValue)][int] $StartSpaces = 0,
        [alias ('L')] [string] $LogFile = '',
        [Alias('DateFormat', 'TimeFormat')][string] $DateTimeFormat = 'yyyy-MM-dd HH:mm:ss',
        [alias ('LogTimeStamp')][bool] $LogTime = $true,
        [ValidateRange(1, [int]::MaxValue)][int] $LogRetry = 2,
        [ValidateSet('unknown', 'string', 'unicode', 'bigendianunicode', 'utf8', 'utf7', 'utf32', 'ascii', 'default', 'oem')][string]$Encoding = 'Unicode',
        [switch] $ShowTime,
        [switch] $NoNewLine,
        [switch] $HorizontalCenter,
        [alias('HideConsole')][switch] $NoConsoleOutput,
        [alias('PL')][ValidateRange(0, [int]::MaxValue)][int] $PadLeft = 0,
        [alias('PC')][ValidateRange(0, [int]::MaxValue)][int] $PadCenter = 0,
        [alias('PR')][ValidateRange(0, [int]::MaxValue)][int] $PadRight = 0,
        [alias('PadChar')][char] $PadCharacter = ' '
    )
    if (@($PadLeft, $PadCenter, $PadRight | Where-Object { $_ -gt 0 }).Count -gt 1) {
        throw 'Specify only one of PadLeft, PadCenter, or PadRight with a positive width.'
    }
    if ($null -eq $Text) {
        $Text = @()
    }
    $TextToFile = $Text -join ''
    # Handle Ignore at this boundary: Windows PowerShell 5.1 cannot pass an inherited
    # Ignore preference through to nested Write-Host calls.
    $SuppressConsole = $NoConsoleOutput -or $PSBoundParameters['InformationAction'] -eq [System.Management.Automation.ActionPreference]::Ignore
    if (-not $SuppressConsole) {
        if ($null -eq $Color -or $Color.Count -eq 0) {
            Write-Error 'Color must contain at least one foreground color.'
            return
        }
        $DefaultColor = $Color[0]
        if ($null -ne $BackGroundColor -and $BackGroundColor.Count -ne $Color.Count) {
            Write-Error "Colors, BackGroundColors parameters count doesn't match. Terminated."
            return
        }
        $PaddingWidth = [Math]::Max($PadLeft, [Math]::Max($PadCenter, $PadRight))
        $MessageLength = $TextToFile.Length
        $PaddingLength = [Math]::Max(0, $PaddingWidth - $MessageLength)
        $LeftPaddingLength = 0
        if ($PadLeft -gt 0) {
            $LeftPaddingLength = $PaddingLength
        } elseif ($PadCenter -gt 0) {
            $LeftPaddingLength = [int][Math]::Floor($PaddingLength / 2)
        }
        $RightPaddingLength = $PaddingLength - $LeftPaddingLength
        $PaddingColors = @{ ForegroundColor = $DefaultColor }
        if ($null -ne $BackGroundColor) {
            $PaddingColors.BackgroundColor = $BackGroundColor[0]
        }
        $EmptyLine = "`n"
        if ($PaddingWidth -gt 0 -and ($LinesBefore -gt 0 -or $LinesAfter -gt 0)) {
            $EmptyLine = ([string]$PadCharacter * $PaddingWidth) + "`n"
        }
        for ($i = 0; $i -lt $LinesBefore; $i++) {
            if ($PaddingWidth -gt 0) {
                Write-Host -Object $EmptyLine @PaddingColors -NoNewline
            } else {
                Write-Host -Object $EmptyLine -NoNewline
            }
        }
        if ($HorizontalCenter) {
            $MessageLength = [Math]::Max($MessageLength, $PaddingWidth)

            try {
                $WindowWidth = [int](Get-Host).UI.RawUI.WindowSize.Width
            } catch {
                # Non-interactive and custom hosts may not implement RawUI.
                $WindowWidth = 0
            }
            $CenterPosition = [int][Math]::Max(0, [Math]::Floor(($WindowWidth - $MessageLength) / 2))
            if ($CenterPosition -gt 0) {
                Write-Host -Object (' ' * $CenterPosition) -NoNewline
            }
        } # Center the line horizontally according to the powershell window size
        if ($StartTab -ne 0) { for ($i = 0; $i -lt $StartTab; $i++) { Write-Host -Object "`t" -NoNewline } }  # Add TABS before text
        if ($StartSpaces -ne 0) { for ($i = 0; $i -lt $StartSpaces; $i++) { Write-Host -Object ' ' -NoNewline } }  # Add SPACES before text
        if ($ShowTime) { Write-Host -Object "[$([datetime]::Now.ToString($DateTimeFormat))] " -NoNewline } # Add Time before output
        if ($LeftPaddingLength -gt 0) {
            Write-Host -Object ([string]$PadCharacter * $LeftPaddingLength) @PaddingColors -NoNewline
        }
        for ($i = 0; $i -lt $Text.Count; $i++) {
            $ColorIndex = 0
            if ($i -lt $Color.Count) {
                $ColorIndex = $i
            }
            if ($null -eq $BackGroundColor) {
                Write-Host -Object $Text[$i] -ForegroundColor $Color[$ColorIndex] -NoNewline
            } else {
                Write-Host -Object $Text[$i] -ForegroundColor $Color[$ColorIndex] -BackgroundColor $BackGroundColor[$ColorIndex] -NoNewline
            }
        }
        if ($RightPaddingLength -gt 0) {
            Write-Host -Object ([string]$PadCharacter * $RightPaddingLength) @PaddingColors -NoNewline
        }
        if ($NoNewLine -eq $true) { Write-Host -NoNewline } else { Write-Host } # Support for no new line
        for ($i = 0; $i -lt $LinesAfter; $i++) {
            if ($PaddingWidth -gt 0) {
                Write-Host -Object $EmptyLine @PaddingColors -NoNewline
            } else {
                Write-Host -Object $EmptyLine -NoNewline
            }
        }
    }
    if ($Text.Count -and $LogFile) {
        $Saved = $false
        $Retry = 0
        do {
            $Retry++
            try {
                if ($LogTime) {
                    "[$([datetime]::Now.ToString($DateTimeFormat))] $TextToFile" | Out-File -LiteralPath $LogFile -Encoding $Encoding -Append -ErrorAction Stop -WhatIf:$false
                } else {
                    $TextToFile | Out-File -LiteralPath $LogFile -Encoding $Encoding -Append -ErrorAction Stop -WhatIf:$false
                }
                $Saved = $true
            } catch {
                if ($Saved -eq $false -and $Retry -eq $LogRetry) {
                    Write-Warning "Write-Color - Couldn't write to log file $($_.Exception.Message). Tried ($Retry/$LogRetry)"
                } else {
                    Write-Warning "Write-Color - Couldn't write to log file $($_.Exception.Message). Retrying... ($Retry/$LogRetry)"
                }
            }
        } until ($Saved -eq $true -or $Retry -ge $LogRetry)
    }
}
