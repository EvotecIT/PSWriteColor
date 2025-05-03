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