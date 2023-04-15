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

	.EXAMPLE  Padding in combination with LinesBefore and LinesAfter
     Write-Color -Text "  $('-'.PadRight(46,'-'))  " -PadRight 50 -PadCharacter ' ' -LinesBefore 1 -Color White -BackGroundColor Blue
     Write-Color -Text "  | $('Table Row 1'.PadRight(42,' ')) |  " -PadRight 50 -PadCharacter ' ' -Color White -BackGroundColor Blue
     Write-Color -Text "  $('-'.PadRight(46,'-'))  " -Color White -BackGroundColor Blue
     Write-Color -Text "  | $('Table Row 2'.PadRight(42,' ')) |  " -PadRight 50 -PadCharacter ' ' -Color White -BackGroundColor Blue
     Write-Color -Text "  $('-'.PadRight(46,'-'))  " -Color White -BackGroundColor Blue
     Write-Color -Text "  | $('Table Row 3'.PadRight(42,' ')) |  " -PadRight 50 -PadCharacter ' ' -Color White -BackGroundColor Blue
     Write-Color -Text "  $('-'.PadRight(46,'-'))  " -Color White -BackGroundColor Blue
     Write-Color -Text "  | $('Table Row 4'.PadRight(42,' ')) |  " -PadRight 50 -PadCharacter ' ' -Color White -BackGroundColor Blue
     Write-Color -Text "  $('-'.PadRight(46,'-'))  " -Color White -BackGroundColor Blue
     Write-Color -Text "  | $('Table Row 5'.PadRight(42,' ')) |  " -PadRight 50 -PadCharacter ' ' -Color White -BackGroundColor Blue
     Write-Color -Text "  $('-'.PadRight(46,'-'))  " -PadRight 50 -PadCharacter ' ' -LinesAfter 1 -Color White -BackGroundColor Blue

	.NOTES
        Additional Notes:
        - TimeFormat https://msdn.microsoft.com/en-us/library/8kb3ddd4.aspx
	#>
	[alias('Write-Colour')]
	[CmdletBinding()]
	param ([alias ('T')] [String[]]$Text,
        [alias ('C', 'ForegroundColor', 'FGC')] [ConsoleColor[]]$Color = [ConsoleColor]::White,
        [alias ('B', 'BGC')] [ConsoleColor[]]$BackGroundColor = $null,
        [alias ('Indent')][int] $StartTab = 0,
	   [alias ('PL')][int] $PadLeft = 0,
	   [alias ('PC')][int] $PadCenter = 0,
	   [alias ('PR')][int] $PadRight = 0,
        [alias ('PadChar')][string] $PadCharacter = ' ',
        [int] $LinesBefore = 0,
        [int] $LinesAfter = 0,
        [int] $StartSpaces = 0,
        [alias ('L')] [string] $LogFile = '',
        [Alias('DateFormat', 'TimeFormat')][string] $DateTimeFormat = 'yyyy-MM-dd HH:mm:ss',
        [alias ('LogTimeStamp')][bool] $LogTime = $true,
        [int] $LogRetry = 2,
        [ValidateSet('unknown', 'string', 'unicode', 'bigendianunicode', 'utf8', 'utf7', 'utf32', 'ascii', 'default', 'oem')][string]$Encoding = 'Unicode',
        [switch] $ShowTime,
        [switch] $NoNewLine)
    $DefaultColor = $Color[0]
    if ($null -ne $BackGroundColor -and $BackGroundColor.Count -ne $Color.Count) {
        Write-Error "Colors, BackGroundColors parameters count doesn't match. Terminated."
        return
    }
    if ($PadRight -gt 0) { if ($Text.Length -ge $PadRight) { $Text = $Text.PadRight($PadRight,$PadCharacter) }
    } elseif ($PadLeft -gt 0) { if ($Text.Length -ge $PadLeft) { $Text = $Text.PadLeft($PadLeft,$PadCharacter) }
    } elseif ($PadCenter -gt 0) { if ($Text.Length -ge $PadCenter) { $($Pad = $($PadCenter - $Text.Length) / 2) }
    		$Text = $($($Text.PadLeft($Pad,$PadCharacter)).PadRight($PadCenter,$PadCharacter)) }
    if ($LinesBefore -ne 0) {
		if ($PadLeft -gt 0) { $Object = "$($PadCharacter.PadRight($PadLeft,$PadCharacter))`n"
		} elseif ($PadCenter -gt 0) { $Object = "$($PadCharacter.PadRight($PadCenter,$PadCharacter))`n"
		} elseif ($PadRight -gt 0) { $Object = "$($PadCharacter.PadRight($PadRight,$PadCharacter))`n"
		} else { $Object = "`n" }
    		for ($i = 0; $i -lt $LinesBefore; $i++) {
			if (($Color) -and ($BackGroundColor)) { Write-Host -Object $Object -ForegroundColor $Color -BackgroundColor $BackGroundColor -NoNewline
			} elseif (($Color) -and (!$BackGroundColor)) { Write-Host -Object $Object -ForegroundColor $Color -NoNewline
			} elseif ((!$Color) -and ($BackGroundColor)) { Write-Host -Object $Object -BackgroundColor $BackGroundColor -NoNewline
			} else { Write-Host -Object $Object -NoNewline } } }
    if ($StartTab -ne 0) { for ($i = 0; $i -lt $StartTab; $i++) { Write-Host -Object "`t" -NoNewline } }
    if ($StartSpaces -ne 0) { for ($i = 0; $i -lt $StartSpaces; $i++) { Write-Host -Object ' ' -NoNewline } }
    if ($ShowTime) { Write-Host -Object "[$([datetime]::Now.ToString($DateTimeFormat))] " -NoNewline }
    if ($Text.Count -ne 0) {
        if ($Color.Count -ge $Text.Count) { if ($null -eq $BackGroundColor) { for ($i = 0; $i -lt $Text.Length; $i++) { Write-Host -Object $Text[$i] -ForegroundColor $Color[$i] -NoNewline } } else { for ($i = 0; $i -lt $Text.Length; $i++) { Write-Host -Object $Text[$i] -ForegroundColor $Color[$i] -BackgroundColor $BackGroundColor[$i] -NoNewline } } } else {
            if ($null -eq $BackGroundColor) {
                for ($i = 0; $i -lt $Color.Length; $i++) { Write-Host -Object $Text[$i] -ForegroundColor $Color[$i] -NoNewline }
                for ($i = $Color.Length; $i -lt $Text.Length; $i++) { Write-Host -Object $Text[$i] -ForegroundColor $DefaultColor -NoNewline }
            } else {
                for ($i = 0; $i -lt $Color.Length; $i++) { Write-Host -Object $Text[$i] -ForegroundColor $Color[$i] -BackgroundColor $BackGroundColor[$i] -NoNewline }
                for ($i = $Color.Length; $i -lt $Text.Length; $i++) { Write-Host -Object $Text[$i] -ForegroundColor $DefaultColor -BackgroundColor $BackGroundColor[0] -NoNewline }
            }
        }
    }
    if ($NoNewLine -eq $true) { Write-Host -NoNewline } else { Write-Host }
    if ($LinesAfter -ne 0) {
		if ($PadLeft -gt 0) { $Object = "$($PadCharacter.PadRight($PadLeft,$PadCharacter))`n"
		} elseif ($PadCenter -gt 0) { $Object = "$($PadCharacter.PadRight($PadCenter,$PadCharacter))`n"
		} elseif ($PadRight -gt 0) { $Object = "$($PadCharacter.PadRight($PadRight,$PadCharacter))`n"
		} else { $Object = "`n" }
    		for ($i = 0; $i -lt $LinesAfter; $i++) {
			if (($Color) -and ($BackGroundColor)) { Write-Host -Object $Object -ForegroundColor $Color -BackgroundColor $BackGroundColor -NoNewline
			} elseif (($Color) -and (!$BackGroundColor)) { Write-Host -Object $Object -ForegroundColor $Color -NoNewline
			} elseif ((!$Color) -and ($BackGroundColor)) { Write-Host -Object $Object -BackgroundColor $BackGroundColor -NoNewline
			} else { Write-Host -Object $Object -NoNewline } } }
    if ($Text.Count -and $LogFile) {
        $TextToFile = ""
        for ($i = 0; $i -lt $Text.Length; $i++) { $TextToFile += $Text[$i] }
        $Saved = $false
        $Retry = 0
        Do {
            $Retry++
            try {
                if ($LogTime) { "[$([datetime]::Now.ToString($DateTimeFormat))] $TextToFile" | Out-File -FilePath $LogFile -Encoding $Encoding -Append -ErrorAction Stop -WhatIf:$false } else { "$TextToFile" | Out-File -FilePath $LogFile -Encoding $Encoding -Append -ErrorAction Stop -WhatIf:$false }
                $Saved = $true
            } catch { if ($Saved -eq $false -and $Retry -eq $LogRetry) { $PSCmdlet.WriteError($_) } else { Write-Warning "Write-Color - Couldn't write to log file $($_.Exception.Message). Retrying... ($Retry/$LogRetry)" } }
        } Until ($Saved -eq $true -or $Retry -ge $LogRetry)
    }
}
