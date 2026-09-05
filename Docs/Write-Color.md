---
external help file: PSWriteColor-help.xml
Module Name: PSWriteColor
online version:
schema: 2.0.0
---

# Write-Color

## SYNOPSIS
Write-Color is a wrapper around Write-Host delivering a lot of additional features for easier color options.

## SYNTAX

```
Write-Color [[-Text] <String[]>] [[-Color] <ConsoleColor[]>] [[-BackGroundColor] <ConsoleColor[]>]
 [[-StartTab] <Int32>] [[-LinesBefore] <Int32>] [[-LinesAfter] <Int32>] [[-StartSpaces] <Int32>]
 [[-LogFile] <String>] [[-DateTimeFormat] <String>] [[-LogTime] <Boolean>] [[-LogRetry] <Int32>]
 [[-Encoding] <String>] [-ShowTime] [-NoNewLine] [-NoConsoleOutput] [<CommonParameters>]
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
```
Write-Color -Text "Red ", "Green ", "Yellow " -Color Red,Green,Yellow
```

### EXAMPLE 2
```
Write-Color -Text "This is text in Green ",
```

"followed by red ",
                  "and then we have Magenta...
",
                  "isn't it fun?
",
                  "Here goes DarkCyan" -Color Green,Red,Magenta,White,DarkCyan

### EXAMPLE 3
```
Write-Color -Text "This is text in Green ",
```

"followed by red ",
                  "and then we have Magenta...
",
                  "isn't it fun?
",
                  "Here goes DarkCyan" -Color Green,Red,Magenta,White,DarkCyan -StartTab 3 -LinesBefore 1 -LinesAfter 1

### EXAMPLE 4
```
Write-Color "1. ", "Option 1" -Color Yellow, Green
```

Write-Color "2.
", "Option 2" -Color Yellow, Green
Write-Color "3.
", "Option 3" -Color Yellow, Green
Write-Color "4.
", "Option 4" -Color Yellow, Green
Write-Color "9.
", "Press 9 to exit" -Color Yellow, Gray -LinesBefore 1

### EXAMPLE 5
```
Write-Color -LinesBefore 2 -Text "This little ","message is ", "written to log ", "file as well." `
```

-Color Yellow, White, Green, Red, Red -LogFile "C:\testing.txt" -TimeFormat "yyyy-MM-dd HH:mm:ss"
Write-Color -Text "This can get ","handy if ", "want to display things, and log actions to file ", "at the same time." \`
            -Color Yellow, White, Green, Red, Red -LogFile "C:\testing.txt"

### EXAMPLE 6
```
Write-Color -T "My text", " is ", "all colorful" -C Yellow, Red, Green -B Green, Green, Yellow
```

Write-Color -t "my text" -c yellow -b green
Write-Color -text "my text" -c red

## PARAMETERS

### -Text
Text to display on screen and write to log file if specified.
Accepts an array of strings.

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
Color of the text.
Accepts an array of colors.
If more than one color is specified it will loop through colors for each string.
If there are more strings than colors it will start from the beginning.
Available colors are: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

```yaml
Type: ConsoleColor[]
Parameter Sets: (All)
Aliases: C, ForegroundColor, FGC
Accepted values: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

Required: False
Position: 2
Default value: White
Accept pipeline input: False
Accept wildcard characters: False
```

### -BackGroundColor
Color of the background.
Accepts an array of colors.
If more than one color is specified it will loop through colors for each string.
If there are more strings than colors it will start from the beginning.
Available colors are: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

```yaml
Type: ConsoleColor[]
Parameter Sets: (All)
Aliases: B, BGC
Accepted values: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

Required: False
Position: 3
Default value: None
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
Position: 4
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
Position: 5
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
Position: 6
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
Position: 7
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogFile
Path to log file.
If not specified no log file will be created.

```yaml
Type: String
Parameter Sets: (All)
Aliases: L

Required: False
Position: 8
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
Position: 9
Default value: Yyyy-MM-dd HH:mm:ss
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogTime
If set to $true it will add time to log file.
Default is $true.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: LogTimeStamp

Required: False
Position: 10
Default value: True
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
Position: 11
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
Position: 12
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
Position: Named
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
Position: Named
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
Position: Named
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
