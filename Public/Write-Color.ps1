Function Write-Color {
    <#
    .SYNOPSIS
    Write-Color is a wrapper around Write-Host delivering a lot of additional features for easier color options and logging.

    .DESCRIPTION
    Write-Color is a wrapper around Write-Host delivering a lot of additional features for easier color options for native powershell, ANSI SGR, ANSI 4-bit color, and ANSI 8-bit color support. 
    It provides easy manipulation of colors, logging output to file (log) and nice formatting options out of the box.

    It provides:
    - Easy manipulation of colors
    - ANSI 4 color support with strings or integers
    - ANSI 8 color support with strings or integers
    - ANSI Text and Line Styles
    - Testing of ANSI support in your console if ANSI coloring or styles used
    - Logging output to file with optional parameters to log timestamps and log levels
    - Nice formatting options out of the box.
    - Ability to use aliases for a number of parameters

    .PARAMETER Text
    Text to display on screen and write to log file if specified.
    Accepts an array of strings.

    .PARAMETER Color
    Color of the text. Accepts an array of colors. If more than one color is specified it will loop through colors for each string.
    If there are more strings than colors it will start from the beginning.

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
    LightGray, LightBlue, LightGreen, LightCyan, LightRed, LightMagenta, LightYellow, LightBlue, LightBlack
    DarkGray, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, DarkBlue

    More info on ANSI avilable at wikipedia
    https://en.wikipedia.org/wiki/ANSI_escape_code

    .PARAMETER BackGroundColor
    Color of the background. Accepts an array of colors. If more than one color is specified it will loop through colors for each string.
    If there are more strings than colors it will start from the beginning.

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
    LightGray, LightBlue, LightGreen, LightCyan, LightRed, LightMagenta, LightYellow, LightBlue, LightBlack
    DarkGray, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, DarkBlue

    More info on ANSI avilable at wikipedia
    https://en.wikipedia.org/wiki/ANSI_escape_code

    .PARAMETER ANSI4
    Switch to enable 4-bit ANSI color mode for terminals that support it. Enables the translation of color names to ANSI 4-bit color codes and the use of ANSI 4-bit color integers.

    .PARAMETER ANSI8
    Switch to enable 8-bit ANSI color mode for terminals that support it. Enables the translation of color names to ANSI 8-bit color codes and the use of ANSI 8-bit color integers.

    .PARAMETER Style
    Custom style parameters for ANSI-enabled terminals. Accepts an array of styles or an array of arrays of styles to apply to multiple text segments.

    .PARAMETER Bold
    Switch to make the whole line bold when using ANSI terminal support. Bold text in PowerShell is converted to to the lighter color value. 
    - For native PowerShell colors, that means you can only bold the Dark colored texts. Running bold on the regular colors will not show any difference. 
    - For ANSI 4-bit colors you can only bold the regular colors. Running bold on the light colors will not show any difference.
    Default is False.
    - For ANSI 8-bit colors, the regular and dark color names support bolding. Running bold on the light colors will not show any difference.

    .PARAMETER Faint
    Switch to make the whole line faint (decreased intensity) when using ANSI terminal support.

    .PARAMETER Italic
    Switch to make the whole line italic when using ANSI terminal support.

    .PARAMETER Underline
    Switch to underline the whole line when using ANSI terminal support.

    .PARAMETER Blink
    Switch to make the whole line blink when using ANSI terminal support.

    .PARAMETER CrossedOut
    Switch to display the whole line with a line through it (strikethrough) when using ANSI terminal support.

    .PARAMETER DoubleUnderline
    Switch to display the whole line with a double underline when using ANSI terminal support.

    .PARAMETER Overline
    Switch to display the whole line with a line above it when using ANSI terminal support.

    .PARAMETER StartTab
    Number of tabs to add before text. Default is 0.

    .PARAMETER LinesBefore
    Number of empty lines before text. Default is 0.

    .PARAMETER LinesAfter
    Number of empty lines after text. Default is 0.

    .PARAMETER StartSpaces
    Number of spaces to add before text. Default is 0.

    .PARAMETER LogFile
    Path to log file or name of the logfile. If only a filename is provided it will put in the LogPath directory; and extension of .log will be appended if no extension is provided.

    .PARAMETER LogPath
    Path to store the log file in if LogFile does not contain a path. If running in a script, it will default to PSScriptRoot. If running in console it will default to the current working directory.

    .PARAMETER DateTimeFormat
    Custom date and time format string. Default is yyyy-MM-dd HH:mm:ss

    .PARAMETER LogLevel
    The log level to include in the log file. Accepts a string. This is only provides options for writing to the log with log levels separate from the text. See logging example.

    .PARAMETER LogTime
    Switch to include the timestamp in the logfile

    .PARAMETER LogRetry
    Number of retries to write to log file, in case it can't write to it for some reason, before skipping. Default is 2.

    .PARAMETER Encoding
    Encoding of the log file. Default is Unicode.

    .PARAMETER ShowTime
    Switch to add time to console output. Default is not set.

    .PARAMETER NoNewLine
    Switch to not add new line at the end of the output. Default is not set.

    .PARAMETER HorizontalCenter
    Calculates the window width and inserts spaces to make the text center according to the present width of the powershell window. Default is false.

    .PARAMETER NoConsoleOutput
    Switch to not output to console. Default all output goes to console.

    .EXAMPLE
    # Writing text with multiple colors
    Write-Color -Text 'Red ', 'Green ', 'Yellow ' -Color Red,Green,Yellow

    .EXAMPLE
    # Writing text with multiple colors and splitting text segments onto new lines for easier readability
    Write-Color -Text 'This is text in Green ',
                      'followed by red ',
                      'and then we have Magenta... ',
                      "isn't it fun? "",
                      'Here goes DarkCyan' -Color Green,Red,Magenta,White,DarkCyan

    .EXAMPLE
    # Formatting with tabs, lines before and after
    Write-Color -Text 'This could be a header with a blank line before and blank line after' -Color Cyan -LinesBefore 1 -LinesAfter 1
    Write-Color -Text 'This is indented content' -Color White -StartTab 2
    Write-Color -Text 'Back to normal indentation' -Color Gray -LinesAfter 1

    .EXAMPLE
    # Horizontal centering
    Write-Color -Text 'This text could be a horiztonally centered header' -Color Green -HorizontalCenter -LinesBefore 1 -LinesAfter 1
    Write-Color -Text 'Important ', 'Warning' -BackGroundColor DarkRed,DarkRed -HorizontalCenter -Bold

    .EXAMPLE
    # ANSI styling with different text effects
    Write-Color -Text 'This text is bold' -Color DarkYellow -Bold
    Write-Color -Text 'This text is italicized' -Color Green -Italic
    Write-Color -Text 'This text is underlined' -Color Cyan -Underline
    Write-Color -Text 'This text blinks' -Color Magenta -Blink
    Write-Color -Text 'This text is crossed out' -Color Red -CrossedOut
    Write-Color -Text 'This text has a double underline' -Color Blue -DoubleUnderline
    Write-Color -Text 'This text has an overline' -Color White -Overline

    .EXAMPLE
    # Complex styling with different effects per text segment
    Write-Color -Text "This segment is bold", " this one is italic", " this one blinks", " this one is crossed out" -Color Yellow,Cyan,Magenta,Red -Style Bold,Italic,Blink,CrossedOut

    .EXAMPLE
    # Applying multiple styles to different text segments using explicit array notation
    Write-Color -Text 'This part is bold and italic', ' and this part is underlined and blinking' -Color DarkYellow,Cyan -Style @('Bold','Italic'),@('Underline','Blink')

    .EXAMPLE
    # ANSI4 color mode. This example shows how Red and DarkRed map to the same color.
    Write-Color -Text 'ANSI4 Light Red ', 'ANSI4 Red ', 'ANSI4 Dark Red' -Color LightRed,Red,DarkRed -ANSI4
    Write-Color -Text 'ANSI4 Light Red with Red Background ', 'ANSI4 Red with Light Red Background' -Color LightRed,Red -BackGroundColor DarkRed,LightRed -ANSI4

    # ANSI4 color mode with integers
    Write-Color -Text 'ANSI4 Light Red ', 'ANSI4 Red ', 'ANSI4 Dark Red' -Color 91,31,31 -ANSI4
    Write-Color -Text 'ANSI4 Light Red with Red Background ', 'ANSI4 Red with Light Red Background' -Color 91,31 -BackGroundColor 41,101 -ANSI4

    .EXAMPLE
    # ANSI8 color mode
    Write-Color -Text 'ANSI 8 Light Red ', 'ANSI 8 Red ', 'ANSI 8 Dark Red' -Color LightRed,Red,DarkRed -ANSI8
    Write-Color -Text 'ANSI 8 Light Red ', 'ANSI 8 Red ', 'ANSI 8 Dark Red' -Color LightRed,Red,DarkRed -BackGroundColor Red,DarkRed,LightRed -ANSI8

    # ANSI8 color mode with integers
    Write-Color -Text 'ANSI 8 Light Red ', 'ANSI 8 Red ', 'ANSI 8 Dark Red' -Color 9,1,52 -ANSI8
    Write-Color -Text 'ANSI 8 Light Red ', 'ANSI 8 Red ', 'ANSI 8 Dark Red' -Color 9,1,52 -BackGroundColor 1,52,9 -ANSI8

    .EXAMPLE
    # Creating menu options
    Write-Color '1. ', 'View System Information   '-Color Yellow,Cyan -BackGroundColor Black -StartTab 2
    Write-Color '2. ', 'Check Disk Space          ' -Color Yellow,Cyan -BackGroundColor Black -StartTab 2
    Write-Color '3. ', 'Scan for Updates          ' -Color Yellow,Cyan -BackGroundColor Black -StartTab 2
    Write-Color '4. ', 'Exit                      ' -Color Yellow,Cyan -BackGroundColor Black -StartTab 2

    .EXAMPLE
    # Writing color and reading input with a zero width space character so there arent two extra spaces after the text is outputted
    Write-Color -Text "Enter the number of your choice: " -Color White -NoNewline -LinesBefore 1; $selected = Read-Host
    Write-Color -Text "Are you sure you want to select $selected"," (Y/","N","): " -Color White,DarkYellow,Green,DarkYellow -NoNewline; $confirmed = Read-Host

    .EXAMPLE
    # Creating status indicators with different styles
    Write-Color '[', 'SUCCESS', '] ' -Color White,Green,White -Style None,Bold,None
    Write-Color '[', 'WARNING', '] ' -Color White,Yellow,White -Style None,Bold,None 
    Write-Color '[', 'ERROR', '] ' -Color White,Red,White -Style None,Bold,None
    Write-Color 'Operation completed with ', '1 ', 'success ', '2 ','warnings and ', '1 ', 'error' -Color White,Green,White,Yellow,White,Red,White

    .EXAMPLE
    # Creating native PWSH dotted line boxed content
    Write-Color "+----------------------+" -Color Cyan
    Write-Color "$([char]166)", " System Status Report ", "$([char]166)" -Color Cyan,White,Cyan
    Write-Color "+----------------------+" -Color Cyan
    Write-Color "$([char]166)", " CPU: ", "42%             ", "$([char]166)" -Color Cyan,White,Green,Cyan
    Write-Color "$([char]166)", " Memory: ", "68%          ", "$([char]166)" -Color Cyan,White,Yellow,Cyan
    Write-Color "$([char]166)", " Disk: ", "89%            ", "$([char]166)" -Color Cyan,White,Red,Cyan
    Write-Color "+----------------------+" -Color Cyan

    .EXAMPLE
    # Creating ANSI solid line boxed content
    Write-Color "|","                      ","|" -Color Cyan, Cyan, Cyan -HorizontalCenter -Style None,Overline,None
    Write-Color "|", " System Status Report ", "|" -Color Cyan,White,Cyan -HorizontalCenter
    Write-Color "|","                      ","|" -Color Cyan, Cyan, Cyan -HorizontalCenter -Style None,Underline,None
    Write-Color "|", " CPU: ", "42%             ", "|" -Color Cyan,White,Green,Cyan -HorizontalCenter
    Write-Color "|", " Memory: ", "68%          ", "|" -Color Cyan,White,Yellow,Cyan -HorizontalCenter
    Write-Color "|", " Disk: ", "89%            ", "|" -Color Cyan,White,Red,Cyan -HorizontalCenter
    Write-Color " ","                      "," " -Color Cyan, Cyan, Cyan -HorizontalCenter -Style None,Overline,None

    .EXAMPLE
    # Using with logging capabilities
    Write-Color -Text "Initializing application..." -Color White  -ShowTime -LogFile "C:\Temp\Write-Color.log" 
    Write-Color -Text "Reading configuration..." -Color White  -ShowTime -LogFile "Write-Color" 
    Write-Color -Text "Configuration ", "loaded successfully" -Color White,Green  -ShowTime -LogFile "Write-Color.log" -LogTime
    Write-Color -Text "Running disk space check" -Color White -ShowTime -LogFile "Write-Color.log" -LogPath "C:\Temp" -LogTime

    .EXAMPLE
    # Using with logging capabilities and log levels.
    # Note: If you use LogLevel and put the loglevel in the text it will show twice in the recorded log
    # This example uses LogLevel parameter and colors the whole line.
    Write-Color -Text "Disk space running low" -Color Yellow  -ShowTime -LogFile "Write-Color.log" -LogLevel "WARNING" -LogTime
    # This example includes the log level in the message instead of the parameter and colors the loglevel only.
    Write-Color -Text "[WARNING] ","Disk space running low" -Color Yellow,Grey  -ShowTime -LogFile "Write-Color.log" -LogTime     
    
    .EXAMPLE
    # Using parameter aliases
    Write-Color -T "Starting ", "process" -C Gray,Blue -L "Write-Color" -ShowTime
    Write-Color -T "Process ", "completed" -C Gray,Green -L "Write-Color.log" -ShowTime
    
    .EXAMPLE
    # Writing out to the log with specific text encoding
    Write-Color -Text 'Testuję czy się ładnie zapisze, czy będą problemy' -Encoding unicode -LogFile 'C:\temp\testinggg.txt' -Color Red -NoConsoleOutput

    .NOTES
    Understanding Custom date and time format strings: https://learn.microsoft.com/en-us/dotnet/standard/base-types/custom-date-and-time-format-strings
    Project support: https://github.com/EvotecIT/PSWriteColor
    Original idea: Josh (https://stackoverflow.com/users/81769/josh)

    #>
    [alias('Write-Colour')]
    [CmdletBinding()]
    param (
        [alias ('T')][string[]] $Text,
        [ValidateScript({$_ -is [string] -or $_ -is [int] -or $_ -is [int[]] -or $_ -is [string[]]})][alias ('C', 'ForegroundColor', 'FGC')][array] $Color = $null,
        [ValidateScript({$_ -is [string] -or $_ -is [int] -or $_ -is [int[]] -or $_ -is [string[]]})][alias ('B', 'BGC')][array] $BackGroundColor = $null,
        [switch] $ANSI4,
        [switch] $ANSI8,
        [ValidateScript({$_ -is [string] -or $_ -is [int] -or $_ -is [int[]] -or $_ -is [string[]] -or $_ -is [object[]]})][alias ('S')][object] $Style = $null,
        [switch] $Bold,
        [switch] $Faint,
        [switch] $Italic,
        [switch] $Underline,
        [switch] $Blink,
        [alias ('Strikethrough')][switch] $CrossedOut,
        [switch] $DoubleUnderline,
        [switch] $Overline,
        [alias ('Indent')][int] $StartTab = 0,
        [int] $LinesBefore = 0,
        [int] $LinesAfter = 0,
        [int] $StartSpaces = 0,
        [alias ('L')][string] $LogFile = '',
        [alias ('LP')][string] $LogPath = $(If ($PSScriptRoot) {$PSScriptRoot} Else {$PWD.Path}),
        [alias ('LL', 'LogLvl')][string] $LogLevel = '',
        [alias ('LT')][switch] $LogTime,
        [Alias('DateFormat', 'TimeFormat', 'Timestamp', 'TS')][string] $DateTimeFormat = 'yyyy-MM-dd HH:mm:ss',
        [int] $LogRetry = 2,
        [ValidateSet('unknown', 'string', 'unicode', 'bigendianunicode', 'utf8', 'utf7', 'utf32', 'ascii', 'default', 'oem')][string]$Encoding = 'Unicode',
        [switch] $ShowTime,
        [switch] $NoNewLine,
        [alias('Center')][switch] $HorizontalCenter,
        [alias('HideConsole', 'NoConsole', 'LogOnly', 'LO')][switch] $NoConsoleOutput
    )

    function Test-AnsiSupport {
        [CmdletBinding()]
        param()
    
        # Initialize collection for results
        $results = [PSCustomObject]@{
            IsAnsiSupported = $False
            Details = @{
                PowerShellVersion = $PSVersionTable.PSVersion.ToString()
                IsConsoleHost = $Host.Name -eq 'ConsoleHost' 
                HasVirtualTerminalProcessing = $False
                HasCompatibleTerminalEnv = $False
                IsPSCore = $PSVersionTable.PSVersion.Major -ge 6
                OperatingSystem = [System.Environment]::OSVersion.Platform
            }
        }
    
        # VT Processing is automatically enabled in PowerShell 7+
        If ($results.Details.IsPSCore) {
            $results.Details.HasVirtualTerminalProcessing = $true
        }
        # Check for console host (ISE doesn't support ANSI)
        elseIf (-not $results.Details.IsConsoleHost) {
            $results.Details.HasVirtualTerminalProcessing = $False
        }
        # Use P/Invoke for Windows PowerShell to check console mode
        elseIf ($results.Details.OperatingSystem -eq 'Win32NT') {
            If ([System.Environment]::OSVersion.Version.Major -eq 10 -and [System.Environment]::OSVersion.Version.Build -ge 16257) {
                try {
                    # Define P/Invoke signatures
                    If (-not ('ConsoleHelper' -as [type])) {
                        Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class ConsoleHelper {
    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern bool GetConsoleMode(IntPtr hConsoleHandle, out uint lpMode);
    
    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern IntPtr GetStdHandle(int nStdHandle);}
"@ -ErrorAction SilentlyContinue
                    }
        
                    If ('ConsoleHelper' -as [type]) {
                        # Constants
                        $STDOUT_HANDLE = -11
                        $ENABLE_VIRTUAL_TERMINAL_PROCESSING = 0x0004
                        
                        # Get console mode
                        $stdoutHandle = [ConsoleHelper]::GetStdHandle($STDOUT_HANDLE)
                        $consoleMode = 0
                        
                        If ([ConsoleHelper]::GetConsoleMode($stdoutHandle, [ref]$consoleMode)) {
                            $results.Details.HasVirtualTerminalProcessing = ($consoleMode -band $ENABLE_VIRTUAL_TERMINAL_PROCESSING) -ne 0
                        }
                    }
                }
                Catch {
                    # P/Invoke failed, continue with other checks
                    $results.Details.HasVirtualTerminalProcessing = $False
                }
            } Else {
                Write-Warning 'PowerShell is not capable of ANSI support on versions if Windows 10 earlier than build 16257'
                Return $False
            }
        }
    
        # Check environment variables that might indicate ANSI support
        $termEnv = [Environment]::GetEnvironmentVariable('TERM')
        $colorTerm = [Environment]::GetEnvironmentVariable('COLORTERM')
        $conEmuANSI = [Environment]::GetEnvironmentVariable('ConEmuANSI')
        
        # Linux/macOS terminals or Windows terminals like ConEmu/cmder
        $results.Details.HasCompatibleTerminalEnv = (
            -not [string]::IsNullOrEmpty($termEnv) -or
            -not [string]::IsNullOrEmpty($colorTerm) -or
            -not [string]::IsNullOrEmpty($conEmuANSI)
        )
    
        # Make the first determination based on system checks
        $results.IsAnsiSupported = $results.Details.HasVirtualTerminalProcessing -or $results.Details.HasCompatibleTerminalEnv
  
        If (-not ($results.IsAnsiSupported)) {
            If (-not $ansiSupport.Details.IsConsoleHost) {
                Write-Warning 'Reason: Not running in compatible console host'
            } elseIf (-not ($ansiSupport.Details.HasVirtualTerminalProcessing -or $ansiSupport.Details.HasCompatibleTerminalEnv)) {
                If ($results.Details.OperatingSystem -eq 'Win32NT' -and -not ($ansiSupport.Details.HasVirtualTerminalProcessing)) {
                    If ([System.Environment]::OSVersion.Version.Major -eq 10 -and [System.Environment]::OSVersion.Version.Build -ge 16257) {
                        # Enable VirtualTerminalProcessing for the current session only
                        # Define P/Invoke signatures
                        Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class ConsoleHelper {
    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern bool GetConsoleMode(IntPtr hConsoleHandle, out uint lpMode);
    
    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern bool SetConsoleMode(IntPtr hConsoleHandle, uint dwMode);
    
    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern IntPtr GetStdHandle(int nStdHandle);
}
"@

                        # Constants
                        $STDOUT_HANDLE = -11
                        $ENABLE_VIRTUAL_TERMINAL_PROCESSING = 0x0004
                        
                        # Get console mode
                        $stdoutHandle = [ConsoleHelper]::GetStdHandle($STDOUT_HANDLE)
                        $consoleMode = 0
                        
                        If ([ConsoleHelper]::GetConsoleMode($stdoutHandle, [ref]$consoleMode)) {
                            # Enable VirtualTerminalProcessing
                            $consoleMode = $consoleMode -bor $ENABLE_VIRTUAL_TERMINAL_PROCESSING
                            $result = [ConsoleHelper]::SetConsoleMode($stdoutHandle, $consoleMode)
                            

                            If (-not $result) {
                                Write-Warning 'ANSI is not supported: Virtual terminal processing is not enabled and we were unable to enable it'
                                Return $False
                            } Else {
                                Write-Warning 'ANSI is supported and has been enabled for this console session only. Recommend enabling it permanently.'
                                Return $True
                            }
                        }
                        Write-Warning 'ANSI support could not be automatically enabled for this console session. Recommend enabling it permanently.'
                        Return $False
                    }
                }
                Write-Warning 'ANSI is not supported: Virtual terminal processing is not enabled'
                Return $False
            }
        } Else {
            Return $True
        }
    }

    $ANSISupport = Test-AnsiSupport
    If (-not $ANSISupport) {
        $Style = @()
        $ANSI4 = $False
        $ANSI8 = $False
    }

    # If we are writing out to the console, skip all console related sections
    If (-not $NoConsoleOutput) {
        # ESC sequences to initiate ANSI styling
        $esc=$([char]27)

        # Hashtable of ANSI styles
        $ANSI = @{
            'Reset' = "$esc[0m"
            'Bold' = "$esc[1m"
            'Faint' = "$esc[2m"
            'Italic' = "$esc[3m"
            'Underline' = "$esc[4m"
            'Blink' = "$esc[5m"
            'CrossedOut' = "$esc[9m"
            'DoubleUnderline' = "$esc[21m"
            'Overline' = "$esc[53m"
            'None' = ""
        }

        $Colors = @{
            # Native Color Families
            # Neutral family
            Black = @('Black',30,40,0);
            Gray = @('Gray',37,107,7);
            DarkGray = @('DarkGray',90,100,8); 
            LightBlack = @('DarkGray',90,100,238); 
            White = @('White',97,47,15);
            
            # Red family
            DarkRed = @('DarkRed',31,41,52); 
            Red = @('Red',31,41,1); 
            LightRed = @('Red',91,101,9); 
            
            # Green family
            DarkGreen = @('DarkGreen',32,42,28); 
            Green = @('Green',32,42,2); 
            LightGreen = @('Green',92,102,10);
            
            # Yellow family
            DarkYellow = @('DarkYellow',33,43,136); 
            Yellow = @('Yellow',33,43,3); 
            LightYellow = @('Yellow',93,103,11);
            
            # Blue family
            DarkBlue = @('DarkBlue',34,44,19); 
            Blue = @('Blue',34,44,4); 
            LightBlue = @('Blue',94,104,12);
            
            # Magenta family
            DarkMagenta = @('DarkMagenta',35,45,90); 
            Magenta = @('Magenta',35,45,5); 
            LightMagenta = @('Magenta',95,105,13);
            
            # Cyan family
            DarkCyan = @('DarkCyan',36,46,30); 
            Cyan = @('Cyan',36,46,6); 
            LightCyan = @('Cyan',96,106,14);
            
            # Additional ANSI 8-bit Color Families
            # Orange family
            DarkOrange = @('DarkYellow',33,43,166); 
            Orange = @('DarkYellow',33,43,208); 
            LightOrange = @('Yellow',33,43,215);
            
            # Purple family
            DarkPurple = @('DarkMagenta',35,45,54); 
            Purple = @('DarkMagenta',35,45,93); 
            LightPurple = @('Magenta',35,45,135);
            
            # Pink family
            DarkPink = @('DarkMagenta',35,45,168); 
            Pink = @('Magenta',35,45,205); 
            LightPink = @('Magenta',95,105,218);
            
            # Brown family
            DarkBrown = @('DarkRed',31,41,88); 
            Brown = @('DarkRed',31,41,130); 
            LightBrown = @('DarkYellow',33,43,173);
            
            # Teal family
            DarkTeal = @('DarkCyan',36,46,23); 
            Teal = @('DarkCyan',36,46,30); 
            LightTeal = @('Cyan',36,46,80);
            
            # Violet family
            DarkViolet = @('DarkMagenta',35,45,128); 
            Violet = @('Magenta',35,45,134); 
            LightViolet = @('Magenta',95,105,177);
            
            # Lime family
            DarkLime = @('DarkGreen',32,42,34); 
            Lime = @('Green',32,42,118); 
            LightLime = @('Green',92,102,119);
            
            # Slate family
            DarkSlate = @('DarkGray',90,100,238); 
            Slate = @('Gray',37,107,102); 
            LightSlate = @('Gray',37,107,103);
            
            # Gold family
            DarkGold = @('DarkYellow',33,43,136); 
            Gold = @('Yellow',33,43,178); 
            LightGold = @('Yellow',93,103,185);
            
            # Sky family
            DarkSky = @('DarkBlue',34,44,24); 
            Sky = @('Blue',34,44,111); 
            LightSky = @('Cyan',36,46,152);
            
            # Coral family
            DarkCoral = @('DarkRed',31,41,167); 
            Coral = @('Red',31,41,209); 
            LightCoral = @('Red',91,101,210);
            
            # Olive family
            DarkOlive = @('DarkGreen',32,42,58); 
            Olive = @('DarkYellow',33,43,100); 
            LightOlive = @('DarkYellow',33,43,107);
            
            # Lavender family
            DarkLavender = @('DarkMagenta',35,45,97); 
            Lavender = @('Magenta',35,45,183); 
            LightLavender = @('Magenta',95,105,189);
            
            # Mint family
            DarkMint = @('DarkGreen',32,42,29); 
            Mint = @('Green',32,42,121); 
            LightMint = @('Green',92,102,157);
            
            # Salmon family
            DarkSalmon = @('DarkRed',31,41,173); 
            Salmon = @('Red',31,41,174); 
            LightSalmon = @('Red',91,101,175);
            
            # Indigo family
            DarkIndigo = @('DarkBlue',34,44,17); 
            Indigo = @('DarkMagenta',35,45,54); 
            LightIndigo = @('Blue',34,44,61);
            
            # Turquoise family
            DarkTurquoise = @('DarkCyan',36,46,31); 
            Turquoise = @('Cyan',36,46,43); 
            LightTurquoise = @('Cyan',96,106,86);
            
            # Ruby family
            DarkRuby = @('DarkRed',31,41,52); 
            Ruby = @('Red',31,41,124); 
            LightRuby = @('Red',91,101,161);
            
            # Jade family
            DarkJade = @('DarkGreen',32,42,22); 
            Jade = @('DarkGreen',32,42,35); 
            LightJade = @('Green',32,42,79);
            
            # Amber family
            DarkAmber = @('DarkYellow',33,43,130); 
            Amber = @('Yellow',33,43,214); 
            LightAmber = @('Yellow',93,103,221);
            
            # Steel family
            DarkSteel = @('DarkGray',90,100,59); 
            Steel = @('Gray',37,107,67); 
            LightSteel = @('White',97,47,146);
            
            # Crimson family
            DarkCrimson = @('DarkRed',31,41,88); 
            Crimson = @('Red',31,41,160); 
            LightCrimson = @('Red',91,101,161);
            
            # Emerald family
            DarkEmerald = @('DarkGreen',32,42,22); 
            Emerald = @('Green',32,42,36); 
            LightEmerald = @('Green',92,102,85);
            
            # Sapphire family
            DarkSapphire = @('DarkBlue',34,44,18); 
            Sapphire = @('Blue',34,44,25); 
            LightSapphire = @('Blue',94,104,69);
            
            # Wine family
            DarkWine = @('DarkRed',31,41,52); 
            Wine = @('DarkRed',31,41,88); 
            LightWine = @('Red',31,41,125);
        }
    
        # If Colors were provided, let's validate the colors over assign a default color
        If ($Color) {
            For ($i = 0; $i -lt $Text.Length; $i++) {
                If ($Color[$i] -is [string]) {
                    If ($Colors.Keys -NotContains $Color[$i]) {
                        Write-Warning "$($Color[$i]) is not a supported color string. The color gray will be assigned instead."
                        # Assign the default color of gray
                        $Color[$i] = 'Gray'
                    }
                    # Assign the default color equal to the first color provided
                    $DefaultColor = $Color[0]
                } ElseIf ($Color[$i] -is [Int32]) {
                    If ($ANSI8) {
                        If ($Color[$i] -notin 0..255) {
                            Write-Warning 'ANSI8 color integers must be between 0 and 255. The color gray will be assigned instead.'
                            # Assign the default color of gray
                            $Color[$i] = 7
                        }
                        $DefaultColor = $Color[0]
                    } ElseIf ($ANSI4) {
                        If ($Color[$i] -notin 30..37 -and $Color[$i] -notin 90..97) {
                            Write-Warning 'ANSI4 color integers must be between 30 and 37 or between 90 and 97. The color white will be assigned instead.'
                            # Assign the default color of gray
                            $Color[$i] = 37
                        }
                        # Assign the default color equal to the first color provided
                        $DefaultColor = $Color[0]
                    } Else {
                        Write-Error 'Integers can only be used for colors if using ANSI coloring. The color grey will be assigned instead.'
                        $Color[$i] = 'Gray'
                        return
                    }
                } ElseIf ($null -ne $Color[$i]) {
                    Write-Error 'Color must be a string or if using ANSI coloring an integer. Terminated.'
                    return
                } Else {
                    # Assign the default color of gray
                    $DefaultColor = $Color[0]
                }
            }
        } Else {
            # Assign default color of gray
            $DefaultColor = 'Gray'
        }

        # If background colors were provided, let's validate the colors and default to no background
        If ($BackGroundColor) {
            For ($i = 0; $i -lt $Text.Length; $i++) {
                If ($BackGroundColor[$i] -is [string]) {
                    If ($BackGroundColor[$i] -eq "None") {
                        # Default to no background color
                        $BackGroundColor[$i] = $Null
                    } ElseIf ($Colors.Keys -NotContains $BackGroundColor[$i]) {
                        Write-Warning "$($BackGroundColor[$i]) is not a supported background color string. No background color will being applied."
                        # Default to no background color
                        $BackGroundColor[$i] = $Null
                    }
                } ElseIf ($BackGroundColor[$i] -is [Int32]) {
                    If ($ANSI8) {
                        If ($BackGroundColor[$i] -notin 0..255) {
                            Write-Warning 'ANSI8 background color integers must be between 0 and 255. No background color will being applied.'
                            # Default to no background color
                            $BackGroundColor[$i] = $Null
                        }
                    } ElseIf ($ANSI4) {
                        If ($BackGroundColor[$i] -notin 40..47 -and $BackGroundColor[$i] -notin 100..107) {
                            Write-Warning 'ANSI4 background color integers must be between 30 and 37 or between 90 and 97. No background color will being applied.'
                            # Default to no background color
                            $BackGroundColor[$i] = $Null
                        }
                    } Else {
                        Write-Error 'Integers can only be used for background colors if using ANSI coloring. No background color will being applied.'
                        $BackGroundColor[$i] = $Null
                        return
                    }
                } ElseIf ($null -ne $BackGroundColor[$i]) {
                    Write-Error 'Color must be a string or if using ANSI coloring an integer. Terminated.'
                    return
                } 
            }
        }

        # If the line is bolded and using strings with ANSI8 coloring, automatically "bold" the line
        If ($ANSI8 -and $Bold) {
            For ($c = 0; $c -lt $Color.Length; $c++) {
                If ($Color[$c] -is [string]) {
                    If ($Color[$c] -like 'Dark*') {
                        $Color[$c] = $Color[$c].Substring(4)
                    } ElseIf ($Color[$c] -notlike 'Dark*' -and $Color[$c] -notlike 'Light*') {
                        $Color[$c] = "Light$($Color[$c])"
                    }
                }
            }
        }

        # Validate text styles if they were applied to individual text segments
        If ($Style) {
            # Store the original invocation line for analysis
            $InvocationLine = $MyInvocation.Line
            
            # Determine if the Style parameter was passed using explicit @() array syntax
            $ExplicitArrayNotation = $InvocationLine -match '-Style\s+@\('
            $ExplicitVariableNotation = $InvocationLine -match '-Style\s+\$[a-zA-Z0-9_]+'
            
            # Check if we're dealing with a style array or nested array
            $StyleIsArrayOfArrays = $false
            
            If ($Style.Length -gt 1) {
                If ($Style[0] -is [array] -or ($Style[1] -is [array] -and $Style[1].Length -gt 0)) {
                    $StyleIsArrayOfArrays = $true
                }
            }
            
            # Determine style application approach based on notation and content
            $ApplyMultipleStylesToFirstSegment = $false
            If ($ExplicitArrayNotation -or $ExplicitVariableNotation) {
                # Style was passed as @(...) or $variable, and is not an array of arrays
                If (-not $StyleIsArrayOfArrays -and $Style.Length -gt 1 -and $Text.Length -gt 1) {
                    $ApplyMultipleStylesToFirstSegment = $true
                }
            }
            
            # Structure the Style array based on how we determined it should be applied
            If ($ApplyMultipleStylesToFirstSegment) {
                # The user intended all styles to apply to the first text segment
                $ConvertedStyle = @()
                $ConvertedStyle += ,$Style  # Add all styles as an array for the first segment
                
                # Add empty style for remaining text segments
                For ($i = 1; $i -lt $Text.Length; $i++) {
                    $ConvertedStyle += @()
                }
                
                $Style = $ConvertedStyle
                $StyleIsArrayOfArrays = $true
            }
            ElseIf (-not $StyleIsArrayOfArrays -and $Style.Length -gt 0) {
                # Handle single string or simple array of styles by converting to array of arrays
                If ($Style -is [string]) {
                    # Single style string - apply to first text segment only
                    $ConvertedStyle = @()
                    $ConvertedStyle += ,@($Style)  # Add as single-element array for first segment
                    
                    # Add empty style for remaining text segments
                    For ($i = 1; $i -lt $Text.Length; $i++) {
                        $ConvertedStyle += @()
                    }
                    
                    $Style = $ConvertedStyle
                    $StyleIsArrayOfArrays = $true
                }
                ElseIf ($Style -is [array] -and $Text.Length -gt 1 -and $Style.Length -le $Text.Length) {
                    # Array of styles with one per text segment (one-to-one mapping)
                    $ConvertedStyle = @()
                    
                    For ($i = 0; $i -lt $Style.Length; $i++) {
                        If ($Style[$i] -is [array]) {
                            $ConvertedStyle += ,$Style[$i]
                        }
                        Else {
                            $ConvertedStyle += ,@($Style[$i])
                        }
                    }
                    
                    # Add empty styles for any remaining segments
                    For ($i = $Style.Length; $i -lt $Text.Length; $i++) {
                        $ConvertedStyle += @()
                    }
                    
                    $Style = $ConvertedStyle
                    $StyleIsArrayOfArrays = $true
                }
            }
            
            # Validate each style against supported styles
            For ($i = 0; $i -lt $Style.Length; $i++) {
                If ($Style[$i] -is [array]) {
                    For ($j = 0; $j -lt $Style[$i].Length; $j++) {
                        If ($ANSI.Keys -notcontains $Style[$i][$j]) {
                            Write-Warning "$($Style[$i][$j]) is not a supported ANSI style. It will be overwritten to cancel ANSI styling."
                            $Style[$i][$j] = $ANSI['None']
                        }
                        
                        # Handle ANSI8 bold styling for individual text segments
                        If ($ANSI8 -and $Style[$i][$j] -eq 'Bold' -and (-not $Bold)) {
                            For ($c = 0; $c -lt $Color.Length; $c++) {
                                If ($c -eq $i -and $Color[$c] -is [string]) {
                                    If ($Color[$c] -like 'Dark*') {
                                        $Color[$c] = $Color[$c].Substring(4)
                                    }
                                    ElseIf ($Color[$c] -notlike 'Dark*' -and $Color[$c] -notlike 'Light*') {
                                        $Color[$c] = "Light$($Color[$c])"
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    
        # Check if we're using ANSI4 or ANSI8 coloring, if not skip for efficiency
        If ($ANSI4 -or $ANSI8) {
            # Process through any color strings and convert them
            If ($Color) {
                For ($i = 0; $i -lt $Text.Length; $i++) {
                    If ($ANSI8) {
                        # If its a string, get the ANSI8 mapping
                        If ($Color[$i] -is [string]) {
                            # If the string is in the hashtable, assign the ANSI8 color integer
                            If ($Colors.Keys -Contains $Color[$i]) {
                                $Color[$i] = $Colors[$Color[$i]][3]
                            # Else assign a default color of White
                            } Else {
                                $Color[$i] = 15
                            }
                        } 
                    } ElseIf ($ANSI4) {
                        # If its a string, get the ANSI4 mapping
                        If ($Color[$i] -is [string]) {
                            # If the string is in the hashtable, assign the ANSI4 color integer
                            If ($Colors.Keys -Contains $Color[$i]) {
                                $Color[$i] = $Colors[$Color[$i]][1]
                            # Else assign a default color of White
                            } Else {
                                $Color[$i] = 37
                            }
                        } 
                    } 
                }
            }
    
            # Process through any background color strings and convert them
            If ($BackGroundColor) {
                For ($i = 0; $i -lt $Text.Length; $i++) {
                    If ($ANSI8) {
                        # If its a string, get the ANSI8 mapping
                        If ($BackGroundColor[$i] -is [string]) {
                            # If the string is in the hashtable, assign the ANSI8 color integer
                            If ($Colors.Keys -Contains $BackGroundColor[$i]) {
                                $BackGroundColor[$i] = $Colors[$BackGroundColor[$i]][3]
                            # Else not default background was applied, add a null value to write without a background color
                            } Else {
                                $BackGroundColor[$i] = $null
                            }
                        }
                    } ElseIf ($ANSI4) {
                        # If its a string, get the ANSI4BG mapping
                        If ($BackGroundColor[$i] -is [string]) {
                            # If the string is in the hashtable, assign the ANSI4BG color integer
                            If ($Colors.Keys -Contains $BackGroundColor[$i]) {
                                $BackGroundColor[$i] = $Colors[$BackGroundColor[$i]][2]
                            # Else not default background was applied, add a null value to write without a background color
                            } Else {
                                $BackGroundColor[$i] = $null
                            }
                        }
                    } 
                }
            }
        }

        If ($LinesBefore -ne 0) {
            For ($i = 0; $i -lt $LinesBefore; $i++) {
                Write-Host -Object "`n" -NoNewline 
            } 
        } # Add empty line before
        If ($HorizontalCenter) {
            $MessageLength = 0
            ForEach ($Value in $Text) {
                $MessageLength += $Value.Length
            }
        
            $WindowWidth = $Host.UI.RawUI.BufferSize.Width
            $CenterPosition = [Math]::Max(0, $WindowWidth / 2 - [Math]::Floor($MessageLength / 2))
        
            # Only write spaces to the console if window width is greater than the message length
            If ($WindowWidth -ge $MessageLength) {
                Write-Host ("{0}" -f (' ' * $CenterPosition)) -NoNewline
            }
        } # Center the line horizontally according to the powershell window size
        If ($StartTab -ne 0) {
            For ($i = 0; $i -lt $StartTab; $i++) {
                Write-Host -Object "`t" -NoNewline 
            } 
        }  # Add TABS before text
        If ($StartSpaces -ne 0) {
            For ($i = 0; $i -lt $StartSpaces; $i++) {
                Write-Host -Object ' ' -NoNewline 
            } 
        }  # Add SPACES before text
        If ($ShowTime) {
            Write-Host -Object "[$([datetime]::Now.ToString($DateTimeFormat))] " -NoNewline -ForegroundColor DarkGray
        } # Add Time before output
        If ($Text.Count -ne 0) {
            If ($Color.Count -ge $Text.Count) {
                # the real deal coloring
                If ($null -eq $BackGroundColor) {
                    For ($i = 0; $i -lt $Text.Length; $i++) {
                        # Initiate parameters for Write-Host
                        $Parameters = @{
                            'Object' = ''
                            'NoNewLine' = $True
                        }

                        If ($ANSISupport) {
                            # If individual text styles were applied, loop through them and apply them to the string
                            If ($Style) {
                                # We have detected that there are more than 1 text segment but only a single array of styles was provided. Apply them only to the first text segment.
                                If ($Text.Length -gt 1 -and $Style.Length -gt 1 -and $Text.Length -ne $Style.Length -and $Style[0] -isnot [array] -and $Style[0] -isnot [char]) {
                                    If ($i -eq 1) {
                                        For ($s = 0; $s -lt $Style.Length; $s++) {
                                            $Parameters['Object'] += $ANSI[$Style[$s]]
                                        }
                                    }
                                } Else {
                                    # For a single string with an array of text styles, we have to loop through each style to apply them
                                    If ($Text.Length -eq 1 -and $Style -is [array]) {
                                        For ($s = 0; $s -lt $Style.Length; $s++) {
                                            $Parameters['Object'] += $ANSI[$Style[$s]]
                                        }
                                    # Else loop through the styles based on if its an array or a string
                                    } Else {
                                        If ($Style[$i] -is [array]) {
                                            ForEach ($TextStyle in $Style[$i]) {
                                                $Parameters['Object'] += $ANSI[$TextStyle]
                                            }
                                        } ElseIf ($Style[$i] -is [string]) {
                                            $Parameters['Object'] += $ANSI[$Style[$i]]
                                        }
                                    }
                                }
                            }

                            # If line styles were applied, apply each one to the whole line
                            If ($Bold) { $Parameters['Object'] += $ANSI['Bold'] }
                            If ($Faint) { $Parameters['Object'] += $ANSI['Faint'] }
                            If ($Italic) { $Parameters['Object'] += $ANSI['Italic'] }
                            If ($Underline) { $Parameters['Object'] += $ANSI['Underline'] }
                            If ($Blink) { $Parameters['Object'] += $ANSI['Blink'] }
                            If ($CrossedOut) { $Parameters['Object'] += $ANSI['CrossedOut'] }
                            If ($DoubleUnderline) { $Parameters['Object'] += $ANSI['DoubleUnderline'] }
                            If ($Overline) { $Parameters['Object'] += $ANSI['Overline'] }
                        }

                        # Set the foreground color based on the type of coloring for the line
                        If ($ANSI8) {
                            $Parameters['Object'] += "$esc[38;5;$($Color[$i])m"
                        } ElseIf ($ANSI4) {
                            $Parameters['Object'] += "$esc[$($Color[$i])m"
                        } Else {
                            $Parameters['ForegroundColor'] = $Color[$i]
                        }

                        # Add the text to output to the console
                        $Parameters['Object'] += $Text[$i]

                        If ($ANSISupport) {
                            # Add the ANSI reset to stop the formatting after printing the text segment
                            $Parameters['Object'] += $ANSI['Reset']
                        }

                        Write-Host @Parameters
                    }
                } Else {
                    For ($i = 0; $i -lt $Text.Length; $i++) {
                        # Initiate parameters for Write-Host
                        $Parameters = @{
                            'Object' = ''
                            'NoNewLine' = $True
                        }

                        If ($ANSISupport) {
                            # If individual text styles were applied, loop through them and apply them to the string
                            If ($Style) {
                                # We have detected that there are more than 1 text segment but only a single array of styles was provided. Apply them only to the first text segment.
                                If ($Text.Length -gt 1 -and $Style.Length -gt 1 -and $Text.Length -ne $Style.Length -and $Style[0] -isnot [array] -and $Style[0] -isnot [char]) {
                                    If ($i -eq 1) {
                                        For ($s = 0; $s -lt $Style.Length; $s++) {
                                            $Parameters['Object'] += $ANSI[$Style[$s]]
                                        }
                                    }
                                } Else {
                                    # For a single string with an array of text styles, we have to loop through each style to apply them
                                    If ($Text.Length -eq 1 -and $Style -is [array]) {
                                        For ($s = 0; $s -lt $Style.Length; $s++) {
                                            $Parameters['Object'] += $ANSI[$Style[$s]]
                                        }
                                    # Else loop through the styles based on if its an array or a string
                                    } Else {
                                        If ($Style[$i] -is [array]) {
                                            ForEach ($TextStyle in $Style[$i]) {
                                                $Parameters['Object'] += $ANSI[$TextStyle]
                                            }
                                        } ElseIf ($Style[$i] -is [string]) {
                                            $Parameters['Object'] += $ANSI[$Style[$i]]
                                        }
                                    }
                                }
                            }

                            # If line styles were applied, apply each one to the whole line
                            If ($Bold) { $Parameters['Object'] += $ANSI['Bold'] }
                            If ($Faint) { $Parameters['Object'] += $ANSI['Faint'] }
                            If ($Italic) { $Parameters['Object'] += $ANSI['Italic'] }
                            If ($Underline) { $Parameters['Object'] += $ANSI['Underline'] }
                            If ($Blink) { $Parameters['Object'] += $ANSI['Blink'] }
                            If ($CrossedOut) { $Parameters['Object'] += $ANSI['CrossedOut'] }
                            If ($DoubleUnderline) { $Parameters['Object'] += $ANSI['DoubleUnderline'] }
                            If ($Overline) { $Parameters['Object'] += $ANSI['Overline'] }
                        }

                        # Set the foreground color based on the type of coloring for the line
                        If ($ANSI8) {
                            $Parameters['Object'] += "$esc[38;5;$($Color[$i])m"
                        } ElseIf ($ANSI4) {
                            $Parameters['Object'] += "$esc[$($Color[$i])m"
                        } Else {
                            $Parameters['ForegroundColor'] = $Color[$i]
                        }

                        # Set the background color based on the type of coloring for the line
                        If ($null -ne $BackGroundColor[$i]) {
                            If ($ANSI8) {
                                $Parameters['Object'] += "$esc[48;5;$($BackGroundColor[$i])m"
                            } ElseIf ($ANSI4) {
                                $Parameters['Object'] += "$esc[$($BackGroundColor[$i])m"
                            } Else {
                                $Parameters['BackgroundColor'] = $BackGroundColor[$i]
                            }
                        }
                        
                        # Add the text to output to the console
                        $Parameters['Object'] += $Text[$i]

                        If ($ANSISupport) {
                            # Add the ANSI reset to stop the formatting after printing the text segment
                            $Parameters['Object'] += $ANSI['Reset']
                        }

                        Write-Host @Parameters
                    }
                }
            } Else {
                If ($null -eq $BackGroundColor) {
                    For ($i = 0; $i -lt $Color.Length ; $i++) {
                        # Initiate parameters for Write-Host
                        $Parameters = @{
                            'Object' = ''
                            'NoNewLine' = $True
                        }

                        If ($ANSISupport) {
                            # If individual text styles were applied, loop through them and apply them to the string
                            If ($Style) {
                                # We have detected that there are more than 1 text segment but only a single array of styles was provided. Apply them only to the first text segment.
                                If ($Text.Length -gt 1 -and $Style.Length -gt 1 -and $Text.Length -ne $Style.Length -and $Style[0] -isnot [array] -and $Style[0] -isnot [char]) {
                                    If ($i -eq 1) {
                                        For ($s = 0; $s -lt $Style.Length; $s++) {
                                            $Parameters['Object'] += $ANSI[$Style[$s]]
                                        }
                                    }
                                } Else {
                                    # For a single string with an array of text styles, we have to loop through each style to apply them
                                    If ($Text.Length -eq 1 -and $Style -is [array]) {
                                        For ($s = 0; $s -lt $Style.Length; $s++) {
                                            $Parameters['Object'] += $ANSI[$Style[$s]]
                                        }
                                    # Else loop through the styles based on if its an array or a string
                                    } Else {
                                        If ($Style[$i] -is [array]) {
                                            ForEach ($TextStyle in $Style[$i]) {
                                                $Parameters['Object'] += $ANSI[$TextStyle]
                                            }
                                        } ElseIf ($Style[$i] -is [string]) {
                                            $Parameters['Object'] += $ANSI[$Style[$i]]
                                        }
                                    }
                                }
                            }

                            # If line styles were applied, apply each one to the whole line
                            If ($Bold) { $Parameters['Object'] += $ANSI['Bold'] }
                            If ($Faint) { $Parameters['Object'] += $ANSI['Faint'] }
                            If ($Italic) { $Parameters['Object'] += $ANSI['Italic'] }
                            If ($Underline) { $Parameters['Object'] += $ANSI['Underline'] }
                            If ($Blink) { $Parameters['Object'] += $ANSI['Blink'] }
                            If ($CrossedOut) { $Parameters['Object'] += $ANSI['CrossedOut'] }
                            If ($DoubleUnderline) { $Parameters['Object'] += $ANSI['DoubleUnderline'] }
                            If ($Overline) { $Parameters['Object'] += $ANSI['Overline'] }
                        }

                        # Set the foreground color based on the type of coloring for the line
                        If ($ANSI8) {
                            $Parameters['Object'] += "$esc[38;5;$($Color[$i])m"
                        } ElseIf ($ANSI4) {
                            $Parameters['Object'] += "$esc[$($Color[$i])m"
                        } Else {
                            $Parameters['ForegroundColor'] = $Color[$i]
                        }

                        # Add the text to output to the console
                        $Parameters['Object'] += $Text[$i]

                        If ($ANSISupport) {
                            # Add the ANSI reset to stop the formatting after printing the text segment
                            $Parameters['Object'] += $ANSI['Reset']
                        }

                        Write-Host @Parameters
                    }
                    For ($i = $Color.Length; $i -lt $Text.Length; $i++) {
                        # Initiate parameters for Write-Host
                        $Parameters = @{
                            'Object' = ''
                            'NoNewLine' = $True
                        }

                        If ($ANSISupport) {
                            # If individual text styles were applied, loop through them and apply them to the string
                            If ($Style) {
                                # We have detected that there are more than 1 text segment but only a single array of styles was provided. Apply them only to the first text segment.
                                If ($Text.Length -gt 1 -and $Style.Length -gt 1 -and $Text.Length -ne $Style.Length -and $Style[0] -isnot [array] -and $Style[0] -isnot [char]) {
                                    If ($i -eq 1) {
                                        For ($s = 0; $s -lt $Style.Length; $s++) {
                                            $Parameters['Object'] += $ANSI[$Style[$s]]
                                        }
                                    }
                                } Else {
                                    # For a single string with an array of text styles, we have to loop through each style to apply them
                                    If ($Text.Length -eq 1 -and $Style -is [array]) {
                                        For ($s = 0; $s -lt $Style.Length; $s++) {
                                            $Parameters['Object'] += $ANSI[$Style[$s]]
                                        }
                                    # Else loop through the styles based on if its an array or a string
                                    } Else {
                                        If ($Style[$i] -is [array]) {
                                            ForEach ($TextStyle in $Style[$i]) {
                                                $Parameters['Object'] += $ANSI[$TextStyle]
                                            }
                                        } ElseIf ($Style[$i] -is [string]) {
                                            $Parameters['Object'] += $ANSI[$Style[$i]]
                                        }
                                    }
                                }
                            }

                            # If line styles were applied, apply each one to the whole line
                            If ($Bold) { $Parameters['Object'] += $ANSI['Bold'] }
                            If ($Faint) { $Parameters['Object'] += $ANSI['Faint'] }
                            If ($Italic) { $Parameters['Object'] += $ANSI['Italic'] }
                            If ($Underline) { $Parameters['Object'] += $ANSI['Underline'] }
                            If ($Blink) { $Parameters['Object'] += $ANSI['Blink'] }
                            If ($CrossedOut) { $Parameters['Object'] += $ANSI['CrossedOut'] }
                            If ($DoubleUnderline) { $Parameters['Object'] += $ANSI['DoubleUnderline'] }
                            If ($Overline) { $Parameters['Object'] += $ANSI['Overline'] }
                        }

                        # Set the foreground color to the default color based on the type of coloring for the line
                        If ($ANSI8) {
                            $Parameters['Object'] += "$esc[38;5;$($DefaultColor)m"
                        } ElseIf ($ANSI4) {
                            $Parameters['Object'] += "$esc[$($DefaultColor)m"
                        } Else {
                            $Parameters['ForegroundColor'] = $DefaultColor
                        }

                        # Add the text to output to the console
                        $Parameters['Object'] += $Text[$i]

                        If ($ANSISupport) {
                            # Add the ANSI reset to stop the formatting after printing the text segment
                            $Parameters['Object'] += $ANSI['Reset']
                        }

                        Write-Host @Parameters
                    }
                }
                Else {
                    For ($i = 0; $i -lt $Color.Length ; $i++) {
                        # Initiate parameters for Write-Host
                        $Parameters = @{
                            'Object' = ''
                            'NoNewLine' = $True
                        }

                        If ($ANSISupport) {
                            # If individual text styles were applied, loop through them and apply them to the string
                            If ($Style) {
                                # We have detected that there are more than 1 text segment but only a single array of styles was provided. Apply them only to the first text segment.
                                If ($Text.Length -gt 1 -and $Style.Length -gt 1 -and $Text.Length -ne $Style.Length -and $Style[0] -isnot [array] -and $Style[0] -isnot [char]) {
                                    If ($i -eq 1) {
                                        For ($s = 0; $s -lt $Style.Length; $s++) {
                                            $Parameters['Object'] += $ANSI[$Style[$s]]
                                        }
                                    }
                                } Else {
                                    # For a single string with an array of text styles, we have to loop through each style to apply them
                                    If ($Text.Length -eq 1 -and $Style -is [array]) {
                                        For ($s = 0; $s -lt $Style.Length; $s++) {
                                            $Parameters['Object'] += $ANSI[$Style[$s]]
                                        }
                                    # Else loop through the styles based on if its an array or a string
                                    } Else {
                                        If ($Style[$i] -is [array]) {
                                            ForEach ($TextStyle in $Style[$i]) {
                                                $Parameters['Object'] += $ANSI[$TextStyle]
                                            }
                                        } ElseIf ($Style[$i] -is [string]) {
                                            $Parameters['Object'] += $ANSI[$Style[$i]]
                                        }
                                    }
                                }
                            }

                            # If line styles were applied, apply each one to the whole line
                            If ($Bold) { $Parameters['Object'] += $ANSI['Bold'] }
                            If ($Faint) { $Parameters['Object'] += $ANSI['Faint'] }
                            If ($Italic) { $Parameters['Object'] += $ANSI['Italic'] }
                            If ($Underline) { $Parameters['Object'] += $ANSI['Underline'] }
                            If ($Blink) { $Parameters['Object'] += $ANSI['Blink'] }
                            If ($CrossedOut) { $Parameters['Object'] += $ANSI['CrossedOut'] }
                            If ($DoubleUnderline) { $Parameters['Object'] += $ANSI['DoubleUnderline'] }
                            If ($Overline) { $Parameters['Object'] += $ANSI['Overline'] }
                        }

                        # Set the foreground color based on the type of coloring for the line
                        If ($ANSI8) {
                            $Parameters['Object'] += "$esc[38;5;$($Color[$i])m"
                        } ElseIf ($ANSI4) {
                            $Parameters['Object'] += "$esc[$($Color[$i])m"
                        } Else {
                            $Parameters['ForegroundColor'] = $Color[$i]
                        }

                        # Set the foreground color based on the type of coloring for the line
                        If ($null -ne $BackGroundColor[$i]) {
                            If ($ANSI8) {
                                $Parameters['Object'] += "$esc[48;5;$($BackGroundColor[$i])m"
                            } ElseIf ($ANSI4) {
                                $Parameters['Object'] += "$esc[$($BackGroundColor[$i])m"
                            } Else {
                                $Parameters['BackgroundColor'] = $BackGroundColor[$i]
                            }
                        }

                        # Add the text to output to the console
                        $Parameters['Object'] += $Text[$i]

                        If ($ANSISupport) {
                            # Add the ANSI reset to stop the formatting after printing the text segment
                            $Parameters['Object'] += $ANSI['Reset']
                        }

                        Write-Host @Parameters
                    }
                    For ($i = $Color.Length; $i -lt $Text.Length; $i++) {
                        # Initiate parameters for Write-Host
                        $Parameters = @{
                            'Object' = ''
                            'NoNewLine' = $True
                        }

                        If ($ANSISupport) {
                            # If individual text styles were applied, loop through them and apply them to the string
                            If ($Style) {
                                # We have detected that there are more than 1 text segment but only a single array of styles was provided. Apply them only to the first text segment.
                                If ($Text.Length -gt 1 -and $Style.Length -gt 1 -and $Text.Length -ne $Style.Length -and $Style[0] -isnot [array] -and $Style[0] -isnot [char]) {
                                    If ($i -eq 1) {
                                        For ($s = 0; $s -lt $Style.Length; $s++) {
                                            $Parameters['Object'] += $ANSI[$Style[$s]]
                                        }
                                    }
                                } Else {
                                    # For a single string with an array of text styles, we have to loop through each style to apply them
                                    If ($Text.Length -eq 1 -and $Style -is [array]) {
                                        For ($s = 0; $s -lt $Style.Length; $s++) {
                                            $Parameters['Object'] += $ANSI[$Style[$s]]
                                        }
                                    # Else loop through the styles based on if its an array or a string
                                    } Else {
                                        If ($Style[$i] -is [array]) {
                                            ForEach ($TextStyle in $Style[$i]) {
                                                $Parameters['Object'] += $ANSI[$TextStyle]
                                            }
                                        } ElseIf ($Style[$i] -is [string]) {
                                            $Parameters['Object'] += $ANSI[$Style[$i]]
                                        }
                                    }
                                }
                            }

                            # If line styles were applied, apply each one to the whole line
                            If ($Bold) { $Parameters['Object'] += $ANSI['Bold'] }
                            If ($Faint) { $Parameters['Object'] += $ANSI['Faint'] }
                            If ($Italic) { $Parameters['Object'] += $ANSI['Italic'] }
                            If ($Underline) { $Parameters['Object'] += $ANSI['Underline'] }
                            If ($Blink) { $Parameters['Object'] += $ANSI['Blink'] }
                            If ($CrossedOut) { $Parameters['Object'] += $ANSI['CrossedOut'] }
                            If ($DoubleUnderline) { $Parameters['Object'] += $ANSI['DoubleUnderline'] }
                            If ($Overline) { $Parameters['Object'] += $ANSI['Overline'] }
                        }

                        # Set the foreground color to the default color based on the type of coloring for the line
                        If ($ANSI8) {
                            $Parameters['Object'] += "$esc[38;5;$($DefaultColor)m"
                        } ElseIf ($ANSI4) {
                            $Parameters['Object'] += "$esc[$($DefaultColor)m"
                        } Else {
                            $Parameters['ForegroundColor'] = $DefaultColor
                        }

                        # Set the foreground color based on the type of coloring for the line
                        If ($null -ne $BackGroundColor[$i]) {
                            If ($ANSI8) {
                                $Parameters['Object'] += "$esc[48;5;$($BackGroundColor[$i])m"
                            } ElseIf ($ANSI4) {
                                $Parameters['Object'] += "$esc[$($BackGroundColor[$i])m"
                            } Else {
                                $Parameters['BackgroundColor'] = $BackGroundColor[$i]
                            }
                        }

                        # Add the text to output to the console
                        $Parameters['Object'] += $Text[$i]

                        If ($ANSISupport) {
                            # Add the ANSI reset to stop the formatting after printing the text segment
                            $Parameters['Object'] += $ANSI['Reset']
                        }

                        Write-Host @Parameters
                    }
                }
            }
        }
        If ($NoNewLine -eq $true) {
            Write-Host -NoNewline 
        } Else {
            Write-Host 
        } # Support for no new line
        If ($LinesAfter -ne 0) {
            For ($i = 0; $i -lt $LinesAfter; $i++) {
                Write-Host -Object "`n" -NoNewline 
            } 
        }  # Add empty line after
    }
    If ($Text.Count -and $LogFile) {
        If (!(Test-Path -Path "$LogPath")) {
            New-Item -ItemType 'Directory' -Path "$LogPath"
        }

        # LogFile is not a path, join the LogPath. This maintains compatibility with $LogFile while allowing a $LogName parameter.
        if ($LogFile -notmatch '[\\/]+') {
            if ($LogFile -notmatch '\.\w+$') {
                $LogFile += '.log'
            }
            $LogFilePath = Join-Path -Path $LogPath -ChildPath "$LogFile"
        } Else {
            $LogFilePath = $LogFile
        }

        # Save to file
        $TextToFile = ''
        For ($i = 0; $i -lt $Text.Length; $i++) {
            $TextToFile += $Text[$i]
        }
        $Saved = $False
        $Retry = 0
        Do {
            $Retry++
            try {
                $LogInfo = ''
                If ($LogTime) {
                    $LogInfo += "[$([datetime]::Now.ToString($DateTimeFormat))]"
                }

                If ($LogLevel.Length -gt 0 ) {
                    $LogInfo += "[$LogLevel]"
                }

                If (-not $LogInfo) {
                    "$TextToFile" | Out-File -FilePath $LogFilePath -Encoding $Encoding -Append -ErrorAction Stop -WhatIf:$False
                } Else {
                    "$LogInfo $TextToFile" | Out-File -FilePath $LogFilePath -Encoding $Encoding -Append -ErrorAction Stop -WhatIf:$False
                }
                $Saved = $true
            } Catch {
                If ($Saved -eq $False -and $Retry -eq $LogRetry) {
                    Write-Warning "Write-Color - Couldn't write to log file $($_.Exception.Message). Tried ($Retry/$LogRetry))"
                } Else {
                    Write-Warning "Write-Color - Couldn't write to log file $($_.Exception.Message). Retrying... ($Retry/$LogRetry)"
                }
            }
        } Until ($Saved -eq $true -or $Retry -ge $LogRetry)
    }
}