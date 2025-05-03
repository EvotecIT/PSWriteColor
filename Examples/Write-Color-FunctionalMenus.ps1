Import-Module .\PSWriteColor.psd1 -Force

# EXAMPLE
$line = '========================================================='

do {
    Clear-Host
    Write-Color $line -LinesBefore 1
    Write-Color 'ACTIVE DIRECTORY Domain Services Section' -C Green -StartTab 1
    Write-Color $line
    Write-Color ' 1', ' - ', 'List of Domain Controller and FSMO Roles' -C Yellow, White, Green
    Write-Color ' 2', ' - ', 'Domain Main Configuration' -C Yellow, White, Green
    Write-Color ' 3', ' - ', 'Forest Main Configuration' -C Yellow, White, Green
    Write-Color ' 4', ' - ', 'List all Windows Clients' -C Yellow, White, Green
    Write-Color ' 5', ' - ', 'List all Windows Server' -C Yellow, White, Green
    Write-Color ' 6', ' - ', 'List all Computer (sort by operatingsystem)' -C Yellow, White, Green
    Write-Color ' 7', ' - ', 'Run systeminfo on remote computers' -C Yellow, White, Green
    Write-Color ' 8', ' - ', 'List Domain Admins' -C Yellow, White, Green
    Write-Color ' 9', ' - ', 'Enabled Optional Features' -C Yellow, White, Green
    Write-Color '10', ' - ', 'List of Active GPOs' -C Yellow, White, Green
    Write-Color '11', ' - ', 'Default Password Policy Settings' -C Yellow, White, Green
    Write-Color '12', ' - ', 'Active Directory Sites' -C Yellow, White, Green
    Write-Color '13', ' - ', 'Users Last Logon' -C Yellow, White, Green
    Write-Color '14', ' - ', 'List all Users (enabled)' -C Yellow, White, Green
    Write-Color '15', ' - ', 'List User Details' -C Yellow, White, Green
    Write-Color '16', ' - ', 'List all Groups' -C Yellow, White, Green
    Write-Color '17', ' - ', 'List Group Memberships' -C Yellow, White, Green
    Write-Color '18', ' - ', 'Send message to users Desktop' -C Yellow, White, Green
    Write-Color '19', ' - ', 'Get Logged on User' -C Yellow, White, Green
    Write-Color ' 0', ' - ', 'Quit' -C Yellow, White, Green -LinesAfter 1
    Write-Color $line

    $inputData = Read-Host 'Select'

    Switch ($inputData) {
        0 { Continue }
        default {
            Write-Color 'Not implemented...', ' Press any key to continue!' -Color Red, Yellow -LinesBefore 1
            [void][System.Console]::ReadKey($true)
        }
    }
} while ($inputData -ne '0')

# EXAMPLE
do {
    Write-Color '1. ', 'View System Information   '-Color Yellow,Cyan -BackGroundColor Black -StartTab 2
    Write-Color '2. ', 'Check Disk Space          ' -Color Yellow,Cyan -BackGroundColor Black -StartTab 2
    Write-Color '3. ', 'Scan for Updates          ' -Color Yellow,Cyan -BackGroundColor Black -StartTab 2
    Write-Color '4. ', 'Exit                      ' -Color Yellow,Cyan -BackGroundColor Black -StartTab 2

    Write-Color -Text "Enter the number of your choice: " -Color White -NoNewline -LinesBefore 1; $selected = Read-Host

    Switch ($selected) {
        1 { Exit }
        2 { Exit }
        3 { Exit }
        4 { Exit }
        default {
            Write-Color 'Not implemented...', ' Press any key to continue!' -Color Red, Yellow -LinesBefore 1
            [void][System.Console]::ReadKey($true)
        }
    }
} while ($selected -notin 1..4)

# EXAMPLE
# Creating native PWSH dotted line boxed content
Write-ColorEX "+----------------------+" -Color Cyan
Write-ColorEX "$([char]166)", " System Status Report ", "$([char]166)" -Color Cyan,White,Cyan
Write-ColorEX "+----------------------+" -Color Cyan
Write-ColorEX "$([char]166)", " CPU: ", "42%             ", "$([char]166)" -Color Cyan,White,Green,Cyan
Write-ColorEX "$([char]166)", " Memory: ", "68%          ", "$([char]166)" -Color Cyan,White,Yellow,Cyan
Write-ColorEX "$([char]166)", " Disk: ", "89%            ", "$([char]166)" -Color Cyan,White,Red,Cyan
Write-ColorEX "+----------------------+" -Color Cyan

# EXAMPLE
# Creating ANSI solid line boxed content
Write-ColorEX "|","                      ","|" -Color Cyan, Cyan, Cyan -HorizontalCenter -Style None,Overline,None
Write-ColorEX "|", " System Status Report ", "|" -Color Cyan,White,Cyan -HorizontalCenter
Write-ColorEX "|","                      ","|" -Color Cyan, Cyan, Cyan -HorizontalCenter -Style None,Underline,None
Write-ColorEX "|", " CPU: ", "42%             ", "|" -Color Cyan,White,Green,Cyan -HorizontalCenter
Write-ColorEX "|", " Memory: ", "68%          ", "|" -Color Cyan,White,Yellow,Cyan -HorizontalCenter
Write-ColorEX "|", " Disk: ", "89%            ", "|" -Color Cyan,White,Red,Cyan -HorizontalCenter
Write-ColorEX " ","                      "," " -Color Cyan, Cyan, Cyan -HorizontalCenter -Style None,Overline,None