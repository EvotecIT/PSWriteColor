---
external help file: PSWriteColor-help.xml
Module Name: PSWriteColor
online version:
schema: 3.0.0
---

# Write-Color

## SYNOPSIS
Write-Color is a wrapper around Write-Host delivering a lot of additional features for easier color options and logging.

## SYNTAX

```
Write-Color [[-Text] <String[]>] [[-Color] <array[]>] [[-BackGroundColor] <array[]>] [-ANSI4] [-ANSI8] 
[[-Style] <object[]>] [-Bold] [-Faint] [-Italic] [-Underline] [-Blink] [-CrossedOut] [-DoubleUnderline] [-Overline] 
[[-StartTab] <Int32>] [[-LinesBefore] <Int32>] [[-LinesAfter] <Int32>] [[-StartSpaces] <Int32>]
[[-LogFile] <String>] [[-LogPath] <String>] [[-DateTimeFormat] <String>] [-LogTime] [[-LogRetry] <Int32>] [[-Encoding] <String>]
[-ShowTime] [-NoNewLine] [-HorizontalCenter] [-NoConsoleOutput] [<CommonParameters>]
```

## DESCRIPTION
Write-Color is a wrapper around Write-Host delivering a lot of additional features for easier color options for native powershell, ANSI SGR, ANSI 4-bit color, and ANSI 8-bit color support. 
It provides easy manipulation of colors, logging output to file (log) and nice formatting options out of the box.

**Features:**

    - Easy manipulation of colors
    - ANSI 4 color support with supported default color names or integers
    - ANSI 8 color support with supported default color names or integers
    - ANSI Text and Line Styles
    - Testing of ANSI support in your console if ANSI coloring or styles used
    - Logging output to file with optional parameters for a log path, log timestamps, and log levels
    - Nice formatting options and examples
    - Ability to use aliases for a number of parameters

## EXAMPLES

### Writing text with multiple colors
```pwsh
Write-Color -Text 'Red ', 'Green ', 'Yellow ' -Color Red,Green,Yellow
```

### Writing text with multiple colors and splitting text segments onto new lines for easier readability
```pwsh
Write-Color -Text 'This is text in Green ',
                  'followed by red ',
                  'and then we have Magenta...',
                  "isn't it fun?",
                  'Here goes DarkCyan' -Color Green,Red,Magenta,White,DarkCyan
```

### Formatting with tabs, lines before and after
```pwsh
Write-Color -Text 'This could be a header with a blank line before and blank line after' -Color Cyan -LinesBefore 1 -LinesAfter 1
Write-Color -Text 'This is indented content' -Color White -StartTab 2
Write-Color -Text 'Back to normal indentation' -Color Gray -LinesAfter 1
```

### Horizontal centering
```pwsh
Write-Color -Text 'This text could be a horiztonally centered header' -Color Green -HorizontalCenter -LinesBefore 1 -LinesAfter 1
Write-Color -Text 'Important ', 'Warning' -BackGroundColor DarkRed,DarkRed -HorizontalCenter -Bold
```

### ANSI line styling with different text effects
```pwsh
Write-Color -Text 'This text is bold' -Color DarkYellow -Bold
Write-Color -Text 'This text is italicized' -Color Green -Italic
Write-Color -Text 'This text is underlined' -Color Cyan -Underline
Write-Color -Text 'This text blinks' -Color Magenta -Blink
Write-Color -Text 'This text is crossed out' -Color Red -CrossedOut
Write-Color -Text 'This text has a double underline' -Color Blue -DoubleUnderline
Write-Color -Text 'This text has an overline' -Color White -Overline
```

### Complex styling with different effects per text segment
```pwsh
Write-Color -Text "This segment is bold", " this one is italic", " this one blinks", " this one is crossed out" -Color Yellow,Cyan,Magenta,Red -Style Bold,Italic,Blink,CrossedOut
```

### Complex styling with multiple styles to different text segments using explicit array notation
```pwsh
Write-Color -Text 'This part is bold and italic', ' and this part is underlined and blinking' -Color DarkYellow,Cyan -Style @('Bold','Italic'),@('Underline','Blink')
```

### ANSI4 color mode
```pwsh
#ANSI4 color mode with color names. Dark colors are not supported and map to the normal color.
Write-Color -Text 'ANSI4 Light Red ', 'ANSI4 Red ', 'ANSI4 Dark Red' -Color LightRed,Red,DarkRed -ANSI4
Write-Color -Text 'ANSI4 Light Red with Red Background ', 'ANSI4 Red with Light Red Background' -Color LightRed,Red -BackGroundColor DarkRed,LightRed -ANSI4

# ANSI4 color mode with integers
Write-Color -Text 'ANSI4 Light Red ', 'ANSI4 Red ', 'ANSI4 Dark Red' -Color 91,31,31 -ANSI4
Write-Color -Text 'ANSI4 Light Red with Red Background ', 'ANSI4 Red with Light Red Background' -Color 91,31 -BackGroundColor 41,101 -ANSI4
```

### ANSI8 color mode
```pwsh
# ANSI8 color mode with color names
Write-Color -Text 'ANSI 8 Light Red ', 'ANSI 8 Red ', 'ANSI 8 Dark Red' -Color LightRed,Red,DarkRed -ANSI8
Write-Color -Text 'ANSI 8 Light Red ', 'ANSI 8 Red ', 'ANSI 8 Dark Red' -Color LightRed,Red,DarkRed -BackGroundColor Red,DarkRed,LightRed -ANSI8

# ANSI8 color mode with integers
Write-Color -Text 'ANSI 8 Light Red ', 'ANSI 8 Red ', 'ANSI 8 Dark Red' -Color 9,1,52 -ANSI8
Write-Color -Text 'ANSI 8 Light Red ', 'ANSI 8 Red ', 'ANSI 8 Dark Red' -Color 9,1,52 -BackGroundColor 1,52,9 -ANSI8
```

### Creating menu options
```pwsh
Write-Color '1. ', 'View System Information   '-Color Yellow,Cyan -BackGroundColor Black -StartTab 2
Write-Color '2. ', 'Check Disk Space          ' -Color Yellow,Cyan -BackGroundColor Black -StartTab 2
Write-Color '3. ', 'Scan for Updates          ' -Color Yellow,Cyan -BackGroundColor Black -StartTab 2
Write-Color '4. ', 'Exit                      ' -Color Yellow,Cyan -BackGroundColor Black -StartTab 2
```

### Writing color and reading input
```pwsh
Write-Color -Text "Enter the number of your choice: " -Color White -NoNewline -LinesBefore 1; $selected = Read-Host
Write-Color -Text "Are you sure you want to select $selected"," (Y/","N","): " -Color White,DarkYellow,Green,DarkYellow -NoNewline; $confirmed = Read-Host
```

### Creating status indicators with different styles
```pwsh
Write-Color '[', 'SUCCESS', '] ' -Color White,Green,White -Style None,Bold,None
Write-Color '[', 'WARNING', '] ' -Color White,Yellow,White -Style None,Bold,None 
Write-Color '[', 'ERROR', '] ' -Color White,Red,White -Style None,Bold,None
Write-Color 'Operation completed with ', '1 ', 'success ', '2 ','warnings and ', '1 ', 'error' -Color White,Green,White,Yellow,White,Red,White
```

### Creating native PWSH dotted line boxed content
```pwsh
Write-Color "+----------------------+" -Color Cyan
Write-Color "$([char]166)", " System Status Report ", "$([char]166)" -Color Cyan,White,Cyan
Write-Color "+----------------------+" -Color Cyan
Write-Color "$([char]166)", " CPU: ", "42%             ", "$([char]166)" -Color Cyan,White,Green,Cyan
Write-Color "$([char]166)", " Memory: ", "68%          ", "$([char]166)" -Color Cyan,White,Yellow,Cyan
Write-Color "$([char]166)", " Disk: ", "89%            ", "$([char]166)" -Color Cyan,White,Red,Cyan
Write-Color "+----------------------+" -Color Cyan
```

### Creating ANSI solid line boxed content
```pwsh
Write-Color "|","                      ","|" -Color Cyan, Cyan, Cyan -HorizontalCenter -Style None,Overline,None
Write-Color "|", " System Status Report ", "|" -Color Cyan,White,Cyan -HorizontalCenter
Write-Color "|","                      ","|" -Color Cyan, Cyan, Cyan -HorizontalCenter -Style None,Underline,None
Write-Color "|", " CPU: ", "42%             ", "|" -Color Cyan,White,Green,Cyan -HorizontalCenter
Write-Color "|", " Memory: ", "68%          ", "|" -Color Cyan,White,Yellow,Cyan -HorizontalCenter
Write-Color "|", " Disk: ", "89%            ", "|" -Color Cyan,White,Red,Cyan -HorizontalCenter
Write-Color " ","                      "," " -Color Cyan, Cyan, Cyan -HorizontalCenter -Style None,Overline,None
```

### Using logging capabilities
```pwsh
Write-Color -Text "Initializing application..." -Color White  -ShowTime -LogFile "C:\Temp\Write-Color.log" 
Write-Color -Text "Reading configuration..." -Color White  -ShowTime -LogFile "Write-Color" 
Write-Color -Text "Configuration ", "loaded successfully" -Color White,Green  -ShowTime -LogFile "Write-Color.log" -LogTime
Write-Color -Text "Running disk space check" -Color White -ShowTime -LogFile "Write-Color.log" -LogPath "C:\Temp" -LogTime
```

### Using log levels
```pwsh
# Note: If you use LogLevel and put the loglevel in the text it will show twice in the recorded log
# This example uses LogLevel parameter and colors the whole line.
Write-Color -Text "Disk space running low" -Color Yellow  -ShowTime -LogFile "Write-Color.log" -LogLevel "WARNING" -LogTime
# This example includes the log level in the message instead of the parameter and colors the loglevel only.
Write-Color -Text "[WARNING] ","Disk space running low" -Color Yellow,Grey  -ShowTime -LogFile "Write-Color.log" -LogTime
```
### Using parameter aliases
```pwsh
Write-Color -T "Starting ", "process" -C Gray,Blue -L "Write-Color" -ShowTime
Write-Color -T "Process ", "completed" -C Gray,Green -L "Write-Color.log" -ShowTime
```

### Writing out to the log with specific text encoding
```pwsh
Write-Color -Text 'Testuję czy się ładnie zapisze, czy będą problemy' -Encoding unicode -LogFile 'C:\temp\testinggg.txt' -Color Red -NoConsoleOutput
```

## PARAMETERS

### -Text
Text to display on screen and write to log file if specified.
Accepts an array of strings.
Default is None.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: T

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Color
Color of the text. Accepts an array of colors. If more than one color is specified it will loop through colors for each string.
If there are more strings than colors it will start from the beginning.
Default is Gray.

#### Available native PWSH colors are: 
White, Green, Cyan, Red, Magenta, Yellow, Gray, Black, 
DarkGray, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, DarkBlue

#### Available ANSI4 colors are (if you supply a Dark color it will be converted into the non-light color automatically if you supply an ANSI 8-bit color name it will be converted to the closest supported matching color): 
White, Green, Cyan, Red, Magenta, Yellow, Gray, Black, 
LightGray, LightBlue, LightGreen, LightCyan, LightRed, LightMagenta, LightYellow, LightBlue

##### ANSI 4 integers
FG Color: 30..37 and 90..97

BG Color 40..47 and 100..107

More info on ANSI avilable at wikipedia
https://en.wikipedia.org/wiki/ANSI_escape_code

#### Available ANSI8 colors are: 
##### Native terminal color families
White, Green, Cyan, Red, Magenta, Yellow, Gray, Black,
LightGray, LightBlue, LightGreen, LightCyan, LightRed, LightMagenta, LightYellow, LightBlue, LightBlack,
DarkGray, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, DarkBlue,
##### Additional color families
Orange, DarkOrange, LightOrange, Purple, DarkPurple, LightPurple, Pink, DarkPink, LightPink,
Brown, DarkBrown, LightBrown, Teal, DarkTeal, LightTeal, Violet, DarkViolet, LightViolet,
Lime, DarkLime, LightLime, Slate, DarkSlate, LightSlate, Gold, DarkGold, LightGold,
Sky, DarkSky, LightSky, Coral, DarkCoral, LightCoral, Olive, DarkOlive, LightOlive,
Lavender, DarkLavender, LightLavender, Mint, DarkMint, LightMint, Salmon, DarkSalmon, LightSalmon,
Indigo, DarkIndigo, LightIndigo, Turquoise, DarkTurquoise, LightTurquoise, Ruby, DarkRuby, LightRuby,
Jade, DarkJade, LightJade, Amber, DarkAmber, LightAmber, Steel, DarkSteel, LightSteel,
Crimson, DarkCrimson, LightCrimson, Emerald, DarkEmerald, LightEmerald, Sapphire, DarkSapphire, LightSapphire,
Wine, DarkWine, LightWine

##### ANSI 8 integers
0..255

More info on ANSI avilable at wikipedia
https://en.wikipedia.org/wiki/ANSI_escape_code

```yaml
Type: Array[]
Parameter Sets: (All)
Aliases: C, ForegroundColor, FGC
Accepted String values: White, Green, Cyan, Red, Magenta, Yellow, Gray, Black, 
LightGray, LightBlue, LightGreen, LightCyan, LightRed, LightMagenta, LightYellow, LightBlue, LightBlack
DarkGray, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, DarkBlue
Accepted ANSI4 Int values:
30..37
90..97
Accepted ANSI8 Int values:
0..255

Required: False
Position: 2
Default value: Gray
Accept pipeline input: False
Accept wildcard characters: False
```

### -BackGroundColor
Color of the background. Accepts an array of colors. If more than one color is specified it will loop through colors for each string.
If there are more strings than colors it will start from the beginning.
Default is None.

Available native PWSH colors are: 
White, Green, Cyan, Red, Magenta, Yellow, Gray, Black, 
DarkGray, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, DarkBlue

Available ANSI4 colors are (if you supply a Dark color it will be converted into the Light color automatically): 
White, Green, Cyan, Red, Magenta, Yellow, Gray, Black, 
LightGray, LightBlue, LightGreen, LightCyan, LightRed, LightMagenta, LightYellow, LightBlue, LightBlack

More info on ANSI avilable at wikipedia
https://en.wikipedia.org/wiki/ANSI_escape_code

Available ANSI8 colors are: 
White, Green, Cyan, Red, Magenta, Yellow, Gray, Black,
LightGray, LightBlue, LightGreen, LightCyan, LightRed, LightMagenta, LightYellow, LightBlue, LightBlack,
DarkGray, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, DarkBlue,
Orange, DarkOrange, LightOrange, Purple, DarkPurple, LightPurple, Pink, DarkPink, LightPink,
Brown, DarkBrown, LightBrown, Teal, DarkTeal, LightTeal, Violet, DarkViolet, LightViolet,
Lime, DarkLime, LightLime, Slate, DarkSlate, LightSlate, Gold, DarkGold, LightGold,
Sky, DarkSky, LightSky, Coral, DarkCoral, LightCoral, Olive, DarkOlive, LightOlive,
Lavender, DarkLavender, LightLavender, Mint, DarkMint, LightMint, Salmon, DarkSalmon, LightSalmon,
Indigo, DarkIndigo, LightIndigo, Turquoise, DarkTurquoise, LightTurquoise, Ruby, DarkRuby, LightRuby,
Jade, DarkJade, LightJade, Amber, DarkAmber, LightAmber, Steel, DarkSteel, LightSteel,
Crimson, DarkCrimson, LightCrimson, Emerald, DarkEmerald, LightEmerald, Sapphire, DarkSapphire, LightSapphire,
Wine, DarkWine, LightWine

More info on ANSI avilable at wikipedia
https://en.wikipedia.org/wiki/ANSI_escape_code

```yaml
Type: Array[]
Parameter Sets: (All)
Aliases: B, BGC
Accepted String values: White, Green, Cyan, Red, Magenta, Yellow, Gray, Black, 
LightGray, LightBlue, LightGreen, LightCyan, LightRed, LightMagenta, LightYellow, LightBlue, LightBlack
DarkGray, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, DarkBlue
Accepted ANSI4 Int values:
40..47
100..107
Accepted ANSI8 Int values:
0..255

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ANSI4
Switch to enable 4-bit ANSI color mode for terminals that support it. Enables the translation of color names to ANSI 4-bit color codes and the use of ANSI 4-bit color integers.
Default is None.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ANSI8
Switch to enable 8-bit ANSI color mode for terminals that support it. Enables the translation of color names to ANSI 8-bit color codes and the use of ANSI 8-bit color integers.
Default is None.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Style
Custom style parameters for ANSI-enabled terminals. Accepts an array of styles or an array of arrays of styles to apply to multiple text segments.
Default is None.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: S
Accepted values: Bold, Faint, Italic, Underline, Blink, CrossedOut, 
DoubleUnderline, Overline 

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Bold
Switch to make the whole line bold when using ANSI terminal support. Bold text in PowerShell is converted to to the lighter color value. 
- For native PowerShell colors, that means you can only bold the Dark colored texts. Running bold on the regular colors will not show any difference. 
- For ANSI 4-bit colors you can only bold the regular colors. Running bold on the light colors will not show any difference.
Default is False.
- For ANSI 8-bit colors, the regular and dark color names support bolding. Running bold on the light colors will not show any difference.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Faint
Switch to make the whole line faint (decreased intensity, darker) when using ANSI terminal support.
Default is False.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Italic
Switch to make the whole line italic when using ANSI terminal support.
Default is False.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Underline
Switch to underline the while line when using ANSI terminal support.
Default is False.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Blink
Switch to make the whole line blink between the regular and faint version of the text when using ANSI terminal support.
Default is False.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -CrossedOut
Switch to display the whole line of the whole line with a line through it (strikethrough) when using ANSI terminal support.
Default is False.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: Strikethrough

Required: False
Position: 12
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DoubleUnderline
Switch to display the whole line with a double underline when using ANSI terminal support.
Default is False.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Overline
Switch to display the whole line with a line above it when using ANSI terminal support.
Default is False.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartTab
Number of tabs to add before text.
Default is 0.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Indent

Required: False
Position: 15
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -LinesBefore
Number of empty lines before text.
Default is 0.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -LinesAfter
Number of empty lines after text.
Default is 0.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartSpaces
Number of spaces to add before text.
Default is 0.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogFile
Path to log file or name of the log file. If no extension is included .log will be appended to the log name.
Default is None.

```yaml
Type: String
Parameter Sets: (All)
Aliases: L

Required: False
Position: 19
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogPath
Path to log file. This parameter is only used if a log name was submitted to the LogFile parameter. 
Default is None.

```yaml
Type: String
Parameter Sets: (All)
Aliases: L

Required: False
Position: 20
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DateTimeFormat
Custom date and time format string.
Default is yyyy-MM-dd HH:mm:ss

```yaml
Type: String
Parameter Sets: (All)
Aliases: DateFormat, TimeFormat

Required: False
Position: 21
Default value: Yyyy-MM-dd HH:mm:ss
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogLevel
The log level to include in the log file. Accepts a string. This is only provides options for writing to the log with log levels separate from the text. See logging example.

```yaml
Type: String
Parameter Sets: (All)
Aliases: LL, LogLvl

Required: False
Position: 22
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogTime
Switch to include the timestamp in the logfile
Default is False

```yaml
Type: Switch
Parameter Sets: (All)
Aliases: LT

Required: False
Position: 23
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogRetry
Number of retries to write to log file, in case it can't write to it for some reason, before skipping.
Default is 2.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: 2
Accept pipeline input: False
Accept wildcard characters: False
```

### -Encoding
Encoding of the log file.
Default is Unicode.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: Unicode
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowTime
Switch to add time to console output.
Default is not set.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoNewLine
Switch to not add new line at the end of the output.
Default is not set.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -HorizontalCenter
Calculates the window width and inserts spaces to make the text center according to the present width of the powershell window. Default is false.
Default is not set.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: Center

Required: False
Position: 28
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoConsoleOutput
Switch to not output to console.
Default all output goes to console.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: HideConsole

Required: False
Position: 29
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Understanding Custom date and time format strings: https://learn.microsoft.com/en-us/dotnet/standard/base-types/custom-date-and-time-format-strings
Project support: https://github.com/EvotecIT/PSWriteColor
Original idea: Josh (https://stackoverflow.com/users/81769/josh)

## RELATED LINKS
