Import-Module .\PSWriteColor.psd1 -Force

# EXAMPLE
Write-ColorEX "[i] ", "Parameter in configuration of ", "EmailParameters.EmailFrom", " exists." -Color White, White, Green, White -ShowTime
Write-ColorEX "[i] ", "Parameter in configuration of ", "EmailParameters.EmailTo", " exists." -Color White, White, Green, White -ShowTime

# EXAMPLE
Write-ColorEX "[i] ", "I will send email soon...", "Get ready.." -Color White
Write-ColorEX "[i] ", "Sending email...." -Color White, White -NoNewLine
<#
    Do Something....
#>
if ($true) {
    Write-ColorEX -Text "OK" -Color Green
}

# EXAMPLE
# Writing text with multiple colors
Write-ColorEX -Text 'Red ', 'Green ', 'Yellow ' -Color Red,Green,Yellow

# EXAMPLE
# Writing text with multiple colors and splitting text segments onto new lines for easier readability
Write-ColorEX -Text 'This is text in Green ',
                  'followed by red ',
                  'and then we have Magenta... ',
                  "isn't it fun? ",
                  'Here goes DarkCyan' -Color Green,Red,Magenta,White,DarkCyan

# EXAMPLE
# Formatting with tabs, lines before and after
Write-ColorEX -Text 'This could be a header with a blank line before and blank line after' -Color Cyan -LinesBefore 1 -LinesAfter 1
Write-ColorEX -Text 'This is indented content' -Color White -StartTab 2
Write-ColorEX -Text 'Back to normal indentation' -Color Gray -LinesAfter 1

# EXAMPLE
# Horizontal centering
Write-ColorEX -Text 'This text could be a horiztonally centered header' -Color Green -HorizontalCenter -LinesBefore 1 -LinesAfter 1
Write-ColorEX -Text 'Important ', 'Warning' -BackGroundColor DarkRed,DarkRed -HorizontalCenter -Bold

#EXAMPLE
# ANSI styling with different text effects
Write-ColorEX -Text 'This text is bold' -Color DarkYellow -Bold
Write-ColorEX -Text 'This text is italicized' -Color Green -Italic
Write-ColorEX -Text 'This text is underlined' -Color Cyan -Underline
Write-ColorEX -Text 'This text blinks' -Color Magenta -Blink
Write-ColorEX -Text 'This text is crossed out' -Color Red -CrossedOut
Write-ColorEX -Text 'This text has a double underline' -Color Blue -DoubleUnderline
Write-ColorEX -Text 'This text has an overline' -Color White -Overline

#EXAMPLE
# Complex styling with different effects per text segment
Write-ColorEX -Text "This segment is bold", " this one is italic", " this one blinks", " this one is crossed out" -Color Yellow,Cyan,Magenta,Red -Style Bold,Italic,Blink,CrossedOut

#EXAMPLE
# Applying multiple styles to different text segments using explicit array notation
Write-ColorEX -Text 'This part is bold and italic', ' and this part is underlined and blinking' -Color DarkYellow,Cyan -Style @('Bold','Italic'),@('Underline','Blink')

#EXAMPLE
# ANSI4 color mode. This example shows how Red and DarkRed map to the same color.
Write-ColorEX -Text 'ANSI4 Light Red ', 'ANSI4 Red ', 'ANSI4 Dark Red' -Color LightRed,Red,DarkRed -ANSI4
Write-ColorEX -Text 'ANSI4 Light Red with Red Background ', 'ANSI4 Red with Light Red Background' -Color LightRed,Red -BackGroundColor DarkRed,LightRed -ANSI4

# ANSI4 color mode with integers
Write-ColorEX -Text 'ANSI4 Light Red ', 'ANSI4 Red ', 'ANSI4 Dark Red' -Color 91,31,31 -ANSI4
Write-ColorEX -Text 'ANSI4 Light Red with Red Background ', 'ANSI4 Red with Light Red Background' -Color 91,31 -BackGroundColor 41,101 -ANSI4

#EXAMPLE
# ANSI8 color mode
Write-ColorEX -Text 'ANSI 8 Light Red ', 'ANSI 8 Red ', 'ANSI 8 Dark Red' -Color LightRed,Red,DarkRed -ANSI8
Write-ColorEX -Text 'ANSI 8 Light Red ', 'ANSI 8 Red ', 'ANSI 8 Dark Red' -Color LightRed,Red,DarkRed -BackGroundColor Red,DarkRed,LightRed -ANSI8

# ANSI8 color mode with integers
Write-ColorEX -Text 'ANSI 8 Light Red ', 'ANSI 8 Red ', 'ANSI 8 Dark Red' -Color 9,1,52 -ANSI8
Write-ColorEX -Text 'ANSI 8 Light Red ', 'ANSI 8 Red ', 'ANSI 8 Dark Red' -Color 9,1,52 -BackGroundColor 1,52,9 -ANSI8

#Blank Line Example
Write-ColorEX '' -BlankLine -Color Green -Underline
Write-ColorEX 'Testing' -Color Green -HorizontalCenter
Write-ColorEX -BlankLine -Color Green -Style Overline
Write-ColorEX 'This text will be overridden by the blankline parameter' -BlankLine -Color Blue -Style Underline
Write-ColorEX 'Testing Again' -Color Blue -HorizontalCenter
Write-ColorEX 'This text will also be overridden by the blankline parameter' -BlankLine -Color Blue -Overline