function Write-Color {
    <#
	.SYNOPSIS
        Write-Color is a wrapper around Write-Host.

        It provides:
        - Easy manipulation of colors,
        - Logging output to file (log)
        - Nice formatting options out of the box.

	.DESCRIPTION
        Author: przemyslaw.klys at evotec.pl
        Project website: https://evotec.xyz/hub/scripts/write-color-ps1/
        Project support: https://github.com/EvotecIT/PSWriteColor

        Original idea: Josh (https://stackoverflow.com/users/81769/josh)

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
	Write-Color -LinesBefore 2 -Text "This little ","message is ", "written to log ", "file as well." `
				-Color Yellow, White, Green, Red, Red -LogFile "C:\testing.txt" -TimeFormat "yyyy-MM-dd HH:mm:ss"
	Write-Color -Text "This can get ","handy if ", "want to display things, and log actions to file ", "at the same time." `
				-Color Yellow, White, Green, Red, Red -LogFile "C:\testing.txt"

    .EXAMPLE
    # Added in 0.5
    Write-Color -T "My text", " is ", "all colorful" -C Yellow, Red, Green -B Green, Green, Yellow
    wc -t "my text" -c yellow -b green
    wc -text "my text" -c red

    .NOTES
        CHANGELOG

        Version 0.5 (25th April 2018)
        -----------
        - Added backgroundcolor
        - Added aliases T/B/C to shorter code
        - Added alias to function (can be used with "WC")
        - Fixes to module publishing

        Version 0.4.0-0.4.9 (25th April 2018)
        -------------------
        - Published as module
        - Fixed small issues

        Version 0.31 (20th April 2018)
        ------------
        - Added Try/Catch for Write-Output (might need some additional work)
        - Small change to parameters

        Version 0.3 (9th April 2018)
        -----------
        - Added -ShowTime
        - Added -NoNewLine
        - Added function description
        - Changed some formatting

        Version 0.2
        -----------
        - Added logging to file

        Version 0.1
        -----------
        - First draft

        Additional Notes:
        - TimeFormat https://msdn.microsoft.com/en-us/library/8kb3ddd4.aspx
    #>
    [CmdletBinding()]
    [Alias('wc')]
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
        [ValidateRange(0, [int32]::MaxValue)]
        [int]
        $StartTab = 0,

        [Alias('LinesBefore')]
        [ValidateRange(0, [int32]::MaxValue)]
        [int]
        $LeadingSpace = 0,

        [Alias('LinesAfter')]
        [ValidateRange(0, [int32]::MaxValue)]
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

    $DefaultColor = $ForegroundColor[0]
    if (
        $BackgroundColor.Count -gt 0 -and $BackgroundColor.Count -ne $ForegroundColor.Count -or
        $ForegroundColor.Count -gt $Message.Count -or
        $BackgroundColor.Count -gt $Message.Count
    ) {
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
    Write-Host -Object ("`n" * $LeadingSpace) -NoNewline

    if ($ShowTime) {
        # Add Time before output
        Write-Host -Object ('[{0}]' -f [datetime]::Now.ToString($DateTimeFormat)) -NoNewline
    }

    # Add TABS before text
    Write-Host -Object ("`t" * $StartTab) -NoNewLine

    if ($ForegroundColor.Count -ge $Message.Count) {
        # The real deal coloring
        for ($i = 0; $i -lt $Message.Length; $i++) {
            $WriteParams = @{
                ForegroundColor = $ForegroundColor[$i]
                BackgroundColor = $BackgroundColor[$i]
                NoNewLine       = $true
            }

            Write-Host -Object $Message[$i] @WriteParams
        }

    }
    else {
        if ($null -eq $BackgroundColor) {
            for ($i = 0; $i -lt $ForegroundColor.Length ; $i++) { Write-Host -Object $Message[$i] -ForegroundColor $ForegroundColor[$i] -NoNewLine }
            for ($i = $ForegroundColor.Length; $i -lt $Message.Length; $i++) { Write-Host -Object $Message[$i] -ForegroundColor $DefaultColor -NoNewLine }
        }
        else {
            for ($i = 0; $i -lt $ForegroundColor.Length ; $i++) { Write-Host -Object $Message[$i] -ForegroundColor $ForegroundColor[$i] -BackgroundColor $BackgroundColor[$i] -NoNewLine }
            for ($i = $ForegroundColor.Length; $i -lt $Message.Length; $i++) { Write-Host -Object $Message[$i] -ForegroundColor $DefaultColor -BackgroundColor $BackgroundColor[0] -NoNewLine }
        }
    }

    if ($NoNewLine -eq $true) { Write-Host -NoNewline } else { Write-Host } # Support for no new line
    if ($TrailingSpace -ne 0) {  for ($i = 0; $i -lt $TrailingSpace; $i++) { Write-Host -Object "`n" } }  # Add empty line after
    if ($LogFile -ne "") {
        # Save to file
        $TextToFile = ""
        for ($i = 0; $i -lt $Message.Length; $i++) {
            $TextToFile += $Message[$i]
        }
        try {
            if ($NoLogTimestamp) {
                Write-Output -InputObject "$TextToFile" |
                    Add-Content -Path $LogFile -Encoding $OutputEncoding
            }
            else {
                Write-Output -InputObject "[$([datetime]::Now.ToString($DateTimeFormat))]$TextToFile" |
                    Add-Content -Path $LogFile -Encoding $OutputEncoding
            }
        }
        catch {
            $PSCmdlet.WriteError($_)
        }
    }
}

Export-ModuleMember -function 'Write-Color' -Alias 'wc'