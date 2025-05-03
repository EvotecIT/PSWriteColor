Import-Module .\PSWriteColor.psd1 -Force

# EXAMPLE
Write-Color "[i] ", "Parameter in configuration of ", "EmailParameters.EmailFrom", " exists." -Color White, White, Green, White -ShowTime
Write-Color "[i] ", "Parameter in configuration of ", "EmailParameters.EmailTo", " exists." -Color White, White, Green, White -ShowTime

# EXAMPLE
Write-Color "[i] ", "I will send email soon...", "Get ready.." -Color White
Write-Color "[i] ", "Sending email...." -Color White, White -NoNewLine
<#
    Do Something....
#>
if ($true) {
    Write-Color -Text "OK" -Color Green
}

# EXAMPLE
# Writing text with multiple colors
Write-Color -Text 'Red ', 'Green ', 'Yellow ' -Color Red,Green,Yellow

# EXAMPLE
# Writing text with multiple colors and splitting text segments onto new lines for easier readability
Write-Color -Text 'This is text in Green ',
                  'followed by red ',
                  'and then we have Magenta... ',
                  "isn't it fun? ",
                  'Here goes DarkCyan' -Color Green,Red,Magenta,White,DarkCyan

# EXAMPLE
# Formatting with tabs, lines before and after
Write-Color -Text 'This could be a header with a blank line before and blank line after' -Color Cyan -LinesBefore 1 -LinesAfter 1
Write-Color -Text 'This is indented content' -Color White -StartTab 2
Write-Color -Text 'Back to normal indentation' -Color Gray -LinesAfter 1

# EXAMPLE
# Horizontal centering
Write-Color -Text 'This text could be a horiztonally centered header' -Color Green -HorizontalCenter -LinesBefore 1 -LinesAfter 1
Write-Color -Text 'Important ', 'Warning' -BackGroundColor DarkRed,DarkRed -HorizontalCenter -Bold
