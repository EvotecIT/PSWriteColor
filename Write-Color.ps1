function Write-Color {
    <#
	.SYNOPSIS
	Write-Color is a wrapper aroun Write-Host.
	It provides:
	- easy manipulation of colors,
	- logging output to file (log)
	- nice formatting options out of the box.
	.DESCRIPTION
	Author: przemyslaw.klys at evotec.pl
	Original link: https://evotec.xyz/powershell-how-to-format-powershell-write-host-with-multiple-colors/
	Original idea: Josh (https://stackoverflow.com/users/81769/josh)

	version 0.31 (20th April 2018)
	- Fixes
	version 0.3 (9th April 2018)
	- added -ShowTime
	- added -NoNewLine
	- added function description
	- changed some formatting
	version 0.2vi
	- added logging to file
	version 0.1
	- first draft

	Notes:
	- TimeFormat https://msdn.microsoft.com/en-us/library/8kb3ddd4.aspx

	.EXAMPLE
	Write-Color -Text "Red ", "Green ", "Yellow " -Color Red,Green,Yellow

	Write-Color -Text "This is text in Green ",
					"followed by red ",
					"and then we have Magenta... ",
					"isn't it fun? ",
					"Here goes DarkCyan" -Color Green,Red,Magenta,White,DarkCyan

	Write-Color -Text "This is text in Green ",
					"followed by red ",
					"and then we have Magenta... ",
					"isn't it fun? ",
					"Here goes DarkCyan" -Color Green,Red,Magenta,White,DarkCyan -StartTab 3 -LinesBefore 1 -LinesAfter 1

	Write-Color "1. ", "Option 1" -Color Yellow, Green
	Write-Color "2. ", "Option 2" -Color Yellow, Green
	Write-Color "3. ", "Option 3" -Color Yellow, Green
	Write-Color "4. ", "Option 4" -Color Yellow, Green
	Write-Color "9. ", "Press 9 to exit" -Color Yellow, Gray -LinesBefore 1

	Write-Color -LinesBefore 2 -Text "This little ","message is ", "written to log ", "file as well." `
				-Color Yellow, White, Green, Red, Red -LogFile "C:\testing.txt" -TimeFormat "yyyy-MM-dd HH:mm:ss"
	Write-Color -Text "This can get ","handy if ", "want to display things, and log actions to file ", "at the same time." `
				-Color Yellow, White, Green, Red, Red -LogFile "C:\testing.txt"
    #>
    param (
        [String[]]$Text,
        [ConsoleColor[]]$Color = [ConsoleColor].White,
        [int] $StartTab = 0,
        [int] $LinesBefore = 0,
        [int] $LinesAfter = 0,
        [string] $LogFile = "",
        [string] $TimeFormat = "yyyy-MM-dd HH:mm:ss",
        [switch] $ShowTime,
        [switch] $NoNewLine
    )
    $DefaultColor = $Color[0]
    if ($LinesBefore -ne 0) {  for ($i = 0; $i -lt $LinesBefore; $i++) { Write-Host "`n" -NoNewline } } # Add empty line before
    if ($ShowTime) { Write-Host "[$([datetime]::Now.ToString($TimeFormat))]" -NoNewline} # Add Time before output
    if ($StartTab -ne 0) {  for ($i = 0; $i -lt $StartTab; $i++) { Write-Host "`t" -NoNewLine } }  # Add TABS before text
    if ($Color.Count -ge $Text.Count) {
        # the real deal coloring
        for ($i = 0; $i -lt $Text.Length; $i++) { Write-Host $Text[$i] -ForegroundColor $Color[$i] -NoNewLine }
    } else {
        for ($i = 0; $i -lt $Color.Length ; $i++) { Write-Host $Text[$i] -ForegroundColor $Color[$i] -NoNewLine }
        for ($i = $Color.Length; $i -lt $Text.Length; $i++) { Write-Host $Text[$i] -ForegroundColor $DefaultColor -NoNewLine }
    }
    if ($NoNewLine -eq $true) { Write-Host -NoNewline } else { Write-Host } # Support for no new line
    if ($LinesAfter -ne 0) {  for ($i = 0; $i -lt $LinesAfter; $i++) { Write-Host "`n" } }  # Add empty line after
    if ($LogFile -ne "") {
        # Save to file
        $TextToFile = ""
        for ($i = 0; $i -lt $Text.Length; $i++) {
            $TextToFile += $Text[$i]
        }
        try {
            Write-Output "[$([datetime]::Now.ToString($TimeFormat))]$TextToFile" | Out-File $LogFile -Encoding unicode -Append
        } catch {
            $_.Exception
        }
    }
}