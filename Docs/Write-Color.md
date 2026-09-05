---
external help file: PSWriteColor-help.xml
Module Name: PSWriteColor
online version: https://github.com/EvotecIT/PSWriteColor
schema: 2.0.0
---
# Write-Color
## SYNOPSIS
Write-Color is a wrapper around Write-Host delivering a lot of additional features for easier color options.

## SYNTAX
### __AllParameterSets
```powershell
Write-Color [[-Text] <string[]>] [[-Color] <ConsoleColor[]>] [[-BackGroundColor] <ConsoleColor[]>] [[-StartTab] <int>] [[-LinesBefore] <int>] [[-LinesAfter] <int>] [[-StartSpaces] <int>] [[-LogFile] <string>] [[-DateTimeFormat] <string>] [[-LogTime] <bool>] [[-LogRetry] <int>] [[-Encoding] <string>] [[-PadLeft] <int>] [[-PadCenter] <int>] [[-PadRight] <int>] [[-PadCharacter] <char>] [-ShowTime] [-NoNewLine] [-HorizontalCenter] [-NoConsoleOutput] [<CommonParameters>]
```

## DESCRIPTION
Write-Color is a wrapper around Write-Host delivering a lot of additional features for easier color options.

It provides:
- Easy manipulation of colors,
- Logging output to file (log)
- Nice formatting options out of the box.
- Ability to use aliases for parameters

## EXAMPLES

### EXAMPLE 1
```powershell
PS > Write-Color -Text "Red ", "Green ", "Yellow " -Color Red,Green,Yellow
```


### EXAMPLE 2
```powershell
PS > Write-Color -Text "This is text in Green ",
                  "followed by red ",
                  "and then we have Magenta... ",
                  "isn't it fun? ",
                  "Here goes DarkCyan" -Color Green,Red,Magenta,White,DarkCyan
```


### EXAMPLE 3
```powershell
PS > Write-Color -Text "This is text in Green ",
                  "followed by red ",
                  "and then we have Magenta... ",
                  "isn't it fun? ",
                  "Here goes DarkCyan" -Color Green,Red,Magenta,White,DarkCyan -StartTab 3 -LinesBefore 1 -LinesAfter 1
```


### EXAMPLE 4
```powershell
PS > Write-Color "1. ", "Option 1" -Color Yellow, Green
Write-Color "2. ", "Option 2" -Color Yellow, Green
Write-Color "3. ", "Option 3" -Color Yellow, Green
Write-Color "4. ", "Option 4" -Color Yellow, Green
Write-Color "9. ", "Press 9 to exit" -Color Yellow, Gray -LinesBefore 1
```


### EXAMPLE 5
```powershell
PS > $LogPath = Join-Path ([IO.Path]::GetTempPath()) 'PSWriteColor.log'
Write-Color -LinesBefore 2 -Text "This little ","message is ", "written to log ", "file as well." `
-Color Yellow, White, Green, Red, Red -LogFile $LogPath -TimeFormat "yyyy-MM-dd HH:mm:ss"
Write-Color -Text "This can get ","handy if ", "want to display things, and log actions to file ", "at the same time." `
-Color Yellow, White, Green, Red, Red -LogFile $LogPath
```


### EXAMPLE 6
```powershell
PS > Write-Color -T "My text", " is ", "all colorful" -C Yellow, Red, Green -B Green, Green, Yellow
Write-Color -t "my text" -c yellow -b green
Write-Color -text "my text" -c red
```


### EXAMPLE 7
```powershell
PS > $LogPath = Join-Path ([IO.Path]::GetTempPath()) 'PSWriteColor.log'
Write-Color -Text "Testuję czy się ładnie zapisze, czy będą problemy" -Encoding unicode -LogFile $LogPath -Color Red -NoConsoleOutput
```


### EXAMPLE 8
```powershell
PS > Write-Color '1. ', 'Start backup' -Color Yellow, White -BackgroundColor Blue, Blue -PadRight 32 -LinesBefore 1
Write-Color '9. ', 'Exit' -Color Yellow, White -BackgroundColor Blue, Blue -PadRight 32 -LinesAfter 1
Write-Color ' MENU ' -PadCenter 32 -PadCharacter '-' -Color Cyan
```


## PARAMETERS

### -BackGroundColor
Background color of each text segment. When supplied, its count must match Color.
Remaining segments use the first background color when there are more strings than colors.
Available colors are: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

```yaml
Type: ConsoleColor[]
Parameter Sets: __AllParameterSets
Aliases: B, BGC
Possible values: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Color
Color of each text segment. Remaining segments use the first color when there are more strings than colors.
Available colors are: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

```yaml
Type: ConsoleColor[]
Parameter Sets: __AllParameterSets
Aliases: C, ForegroundColor, FGC
Possible values: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

Required: False
Position: 1
Default value: White
Accept pipeline input: False
Accept wildcard characters: False
```

### -DateTimeFormat
Custom date and time format string. Default is yyyy-MM-dd HH:mm:ss

```yaml
Type: String
Parameter Sets: __AllParameterSets
Aliases: DateFormat, TimeFormat
Possible values:

Required: False
Position: 8
Default value: yyyy-MM-dd HH:mm:ss
Accept pipeline input: False
Accept wildcard characters: False
```

### -Encoding
Encoding of the log file. Default is Unicode.

```yaml
Type: String
Parameter Sets: __AllParameterSets
Aliases: None
Possible values: unknown, string, unicode, bigendianunicode, utf8, utf7, utf32, ascii, default, oem

Required: False
Position: 11
Default value: Unicode
Accept pipeline input: False
Accept wildcard characters: False
```

### -HorizontalCenter
Centers single-line text, including its padding, in the visible host window. Odd extra space goes on the right.
Indentation and timestamps are added after centering. If the host cannot report its window width, no centering spaces are added.

```yaml
Type: SwitchParameter
Parameter Sets: __AllParameterSets
Aliases: None
Possible values:

Required: False
Position: named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -LinesAfter
Number of empty lines after text. Default is 0.

```yaml
Type: Int32
Parameter Sets: __AllParameterSets
Aliases: None
Possible values:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -LinesBefore
Number of empty lines before text. Default is 0.

```yaml
Type: Int32
Parameter Sets: __AllParameterSets
Aliases: None
Possible values:

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogFile
Literal path to the log file. If not specified no log file will be created.
Appends joined text with a newline, regardless of NoNewLine. Parent directories must already exist.
File-write failures produce warnings after up to LogRetry attempts.

```yaml
Type: String
Parameter Sets: __AllParameterSets
Aliases: L
Possible values:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogRetry
Maximum number of file-write attempts, including the first attempt. Must be at least 1. Default is 2.

```yaml
Type: Int32
Parameter Sets: __AllParameterSets
Aliases: None
Possible values:

Required: False
Position: 10
Default value: 2
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogTime
If set to $true it will add time to log file. Default is $true.

```yaml
Type: Boolean
Parameter Sets: __AllParameterSets
Aliases: LogTimeStamp
Possible values:

Required: False
Position: 9
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoConsoleOutput
Switch to not output to console. Default all output goes to console.

```yaml
Type: SwitchParameter
Parameter Sets: __AllParameterSets
Aliases: HideConsole
Possible values:

Required: False
Position: named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoNewLine
Switch to not add new line at the end of the output. Default is not set.

```yaml
Type: SwitchParameter
Parameter Sets: __AllParameterSets
Aliases: None
Possible values:

Required: False
Position: named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PadCenter
Minimum combined text width, with padding on both sides. An odd extra character goes on the right.

```yaml
Type: Int32
Parameter Sets: __AllParameterSets
Aliases: PC
Possible values:

Required: False
Position: 13
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -PadCharacter
Single character used for padding. Default is a space.
Padding uses the first foreground/background colors. With padding enabled, LinesBefore and LinesAfter
also fill the requested width with this character and these colors.

```yaml
Type: Char
Parameter Sets: __AllParameterSets
Aliases: PadChar
Possible values:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PadLeft
Minimum combined text width, with padding before the first colored segment. Default is 0 (disabled).
Width counts string characters, not terminal display cells; use single-line text without tabs or ANSI sequences.
Text is never truncated. Indentation and timestamps are outside this width; log text is unchanged.
Specify only one positive padding width per call.

```yaml
Type: Int32
Parameter Sets: __AllParameterSets
Aliases: PL
Possible values:

Required: False
Position: 12
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -PadRight
Minimum combined text width, with padding after the last colored segment.

```yaml
Type: Int32
Parameter Sets: __AllParameterSets
Aliases: PR
Possible values:

Required: False
Position: 14
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowTime
Switch to add time to console output. Default is not set.

```yaml
Type: SwitchParameter
Parameter Sets: __AllParameterSets
Aliases: None
Possible values:

Required: False
Position: named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartSpaces
Number of spaces to add before text. Default is 0.

```yaml
Type: Int32
Parameter Sets: __AllParameterSets
Aliases: None
Possible values:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartTab
Number of tabs to add before text. Default is 0.

```yaml
Type: Int32
Parameter Sets: __AllParameterSets
Aliases: Indent
Possible values:

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Text
Text to display on screen and write to log file if specified.
Accepts an array of strings.

```yaml
Type: String[]
Parameter Sets: __AllParameterSets
Aliases: T
Possible values:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

- `None`

## OUTPUTS

- `None`

## RELATED LINKS

- None
