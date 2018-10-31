function Write-ColorDev {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)]
        [Alias('Text')]
        [string[]]
        $Message,

        [Alias('Color', 'FGC')]
        [ConsoleColor[]]
        $ForegroundColor = 'White',

        [Alias('BGC')]
        [ConsoleColor[]]
        $BackgroundColor,

        [Alias('StartTab')]
        [ValidateRange(0, 5)]
        [int]
        $Indent = 0,

        [Alias('LinesBefore')]
        [ValidateRange(0, 10)]
        [int]
        $LeadingSpace = 0,

        [Alias('LinesAfter')]
        [ValidateRange(0, 10)]
        [int]
        $TrailingSpace = 0,

        [Alias('File', 'L')]
        [ValidateScript( { Test-Path -IsValid $_ })]
        [string]
        $LogFile,

        [Alias('DateFormat', 'TimeFormat')]
        [string]
        $DateTimeFormat = "yyyy-MM-dd HH:mm:ss",

        [Alias('LTS')]
        [switch]
        $NoLogTimestamp,

        [Alias('Encoding')]
        [System.Text.Encoding]
        $OutputEncoding = [System.Text.Encoding]::UTF8,

        [switch]
        $ShowTime,

        [switch]
        $NoNewLine
    )
    begin {
        if ($PSBoundParameters.ContainsKey('LogFile')) { $StringBuilder = [System.Text.StringBuilder]::new() }

        $InvalidParams = ($BackgroundColor.Count -gt 0 -and $BackgroundColor.Count -ne $ForegroundColor.Count) -or
        $ForegroundColor.Count -gt $Message.Count -or
        $BackgroundColor.Count -gt $Message.Count

        if ($InvalidParams) {
            $ErrorRecord = [System.Management.Automation.ErrorRecord]::new(
                [System.Management.Automation.ParameterBindingException]::new(
                    'The number of provided Foreground and Background colors does not match, or more colors were provided than entered messages.'
                ),
                'InvalidColorMapping', # ErrorID
                [System.Management.Automation.ErrorCategory]::InvalidArgument, # Category
                $null # Target
            )

            $PSCmdlet.ThrowTerminatingError($ErrorRecord)
        }

        # Add leading lines
        Write-Host ("`n" * $LeadingSpace) @BaseParams

        if ($ShowTime) {
            # Add Time before output
            Write-Host ('[{0}]' -f [datetime]::Now.ToString($DateTimeFormat)) @BaseParams
        }
    }
    process {
        # Add TABS before text
        Write-Host ("`t" * $Indent) @BaseParams

        if ($PSBoundParameters.ContainsKey('ForegroundColor') -or $PSBoundParameters.ContainsKey('BackgroundColor')) {
            # Fallback defaults if one of the values isn't set
            $LastForegroundColor = [console]::ForegroundColor
            $LastForegroundColor = [console]::BackgroundColor

            # The real deal coloring
            for ($i = 0; $i -lt $Message.Count; $i++) {
                $CurrentFGColor = if ($ForegroundColor[$i]) { $ForegroundColor[$i] } else { $LastForegroundColor }
                $CurrentBGColor = if ($BackgroundColor[$i]) { $BackgroundColor[$i] } else { $LastBackgroundColor }

                $WriteParams = @{
                    NoNewLine       = $true
                    ForegroundColor = $CurrentFGColor
                    BackgroundColor = $CurrentBGColor
                }

                Write-Host $Message[$i] @WriteParams
                if ($PSBoundParameters.ContainsKey('LogFile')) { $StringBuilder.Append($Message[$i]) > $null }

                # Store last color set, in case next iteration doesn't have a set color
                $LastForegroundColor, $LastBackgroundColor = $CurrentFGColor, $CurrentBGColor
            }
        } else {
            Write-Host $Message -NoNewline
        }

        if (-not $NoNewLine) {
            Write-Host
        }

        Write-Host ("`n" * $TrailingSpace) # Add empty line after
    }
    end {
        if ($PSBoundParameters.ContainsKey('LogFile')) {
            # Save to file

            try {
                if ($NoLogTimestamp) {
                    $StringBuilder.ToString() | Add-Content -Path $LogFile -Encoding $OutputEncoding
                } else {
                    "[{0}]{1}" -f [datetime]::Now.ToString($DateTimeFormat), $StringBuilder.ToString() |
                        Add-Content -Path $LogFile -Encoding $OutputEncoding
                }
            } catch {
                $PSCmdlet.WriteError($_)
            }
        }
    }
}