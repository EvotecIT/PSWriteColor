function Write-Color {
    [CmdletBinding()]
    [Alias("wc")]
    param (
        [alias ("T")] [String[]]$Text,
        [alias ("C")] [ConsoleColor[]]$Color = "White",
        [alias ("B")] [ConsoleColor[]]$BackGroundColor = $null,
        [int] $StartTab = 0,
        [int] $LinesBefore = 0,
        [int] $LinesAfter = 0,
        [int] $StartSpaces = 0,
        [alias ("L")] [string] $LogFile = "",
        [string] $TimeFormat = "yyyy-MM-dd HH:mm:ss",
        [alias ('LogTimeStamp')][bool] $LogTime = $true,
        [ValidateSet("unknown", "string", "unicode", "bigendianunicode", "utf8", "utf7", "utf32", "ascii", "default", "oem")][string]$Encoding = 'Unicode',
        [switch] $ShowTime,
        [switch] $NoNewLine
    )
    $DefaultColor = $Color[0]
    if ($null -ne $BackGroundColor -and $BackGroundColor.Count -ne $Color.Count) { Write-Error "Colors, BackGroundColors parameters count doesn't match. Terminated." ; return }
    if ($Text.Count -eq 0) { return }
    if ($LinesBefore -ne 0) {  for ($i = 0; $i -lt $LinesBefore; $i++) { Write-Host -Object "`n" -NoNewline } } # Add empty line before
    if ($ShowTime) { Write-Host -Object "[$([datetime]::Now.ToString($TimeFormat))]" -NoNewline} # Add Time before output
    if ($StartTab -ne 0) {  for ($i = 0; $i -lt $StartTab; $i++) { Write-Host -Object "`t" -NoNewLine } }  # Add TABS before text
    if ($StartSpaces -ne 0) {  for ($i = 0; $i -lt $StartSpaces; $i++) { Write-Host -Object ' ' -NoNewLine } }  # Add SPACES before text
    if ($Color.Count -ge $Text.Count) {
        # the real deal coloring
        if ($null -eq $BackGroundColor) {
            for ($i = 0; $i -lt $Text.Length; $i++) { Write-Host -Object $Text[$i] -ForegroundColor $Color[$i] -NoNewLine }
        } else {
            for ($i = 0; $i -lt $Text.Length; $i++) { Write-Host -Object $Text[$i] -ForegroundColor $Color[$i] -BackgroundColor $BackGroundColor[$i] -NoNewLine }
        }
    } else {
        if ($null -eq $BackGroundColor) {
            for ($i = 0; $i -lt $Color.Length ; $i++) { Write-Host -Object $Text[$i] -ForegroundColor $Color[$i] -NoNewLine }
            for ($i = $Color.Length; $i -lt $Text.Length; $i++) { Write-Host -Object $Text[$i] -ForegroundColor $DefaultColor -NoNewLine }
        } else {
            for ($i = 0; $i -lt $Color.Length ; $i++) { Write-Host -Object $Text[$i] -ForegroundColor $Color[$i] -BackgroundColor $BackGroundColor[$i] -NoNewLine }
            for ($i = $Color.Length; $i -lt $Text.Length; $i++) { Write-Host -Object $Text[$i] -ForegroundColor $DefaultColor -BackgroundColor $BackGroundColor[0] -NoNewLine }
        }
    }
    if ($NoNewLine -eq $true) { Write-Host -NoNewline } else { Write-Host } # Support for no new line
    if ($LinesAfter -ne 0) {  for ($i = 0; $i -lt $LinesAfter; $i++) { Write-Host -Object "`n" -NoNewline } }  # Add empty line after
    if ($LogFile -ne "") {
        # Save to file
        $TextToFile = ""
        for ($i = 0; $i -lt $Text.Length; $i++) {
            $TextToFile += $Text[$i]
        }
        try {
            if ($LogTime) {
                Write-Output -InputObject "[$([datetime]::Now.ToString($TimeFormat))]$TextToFile" | Out-File -FilePath $LogFile -Encoding $Encoding -Append
            } else {
                Write-Output -InputObject "$TextToFile" | Out-File -FilePath $LogFile -Encoding $Encoding -Append
            }
        } catch {
            $_.Exception
        }
    }
}