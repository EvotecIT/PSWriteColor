Import-Module .\PSWriteColor.psd1 -Force

# EXAMPLE
# Creating native PWSH dotted line boxed content
Write-Color "+----------------------+" -Color Cyan
Write-Color "$([char]166)", " System Status Report ", "$([char]166)" -Color Cyan,White,Cyan
Write-Color "+----------------------+" -Color Cyan
Write-Color "$([char]166)", " CPU: ", "42%             ", "$([char]166)" -Color Cyan,White,Green,Cyan
Write-Color "$([char]166)", " Memory: ", "68%          ", "$([char]166)" -Color Cyan,White,Yellow,Cyan
Write-Color "$([char]166)", " Disk: ", "89%            ", "$([char]166)" -Color Cyan,White,Red,Cyan
Write-Color "+----------------------+" -Color Cyan

# EXAMPLE
# Creating ANSI solid line boxed content
Write-Color "|","                      ","|" -Color Cyan, Cyan, Cyan -HorizontalCenter -Style None,Overline,None
Write-Color "|", " System Status Report ", "|" -Color Cyan,White,Cyan -HorizontalCenter
Write-Color "|","                      ","|" -Color Cyan, Cyan, Cyan -HorizontalCenter -Style None,Underline,None
Write-Color "|", " CPU: ", "42%             ", "|" -Color Cyan,White,Green,Cyan -HorizontalCenter
Write-Color "|", " Memory: ", "68%          ", "|" -Color Cyan,White,Yellow,Cyan -HorizontalCenter
Write-Color "|", " Disk: ", "89%            ", "|" -Color Cyan,White,Red,Cyan -HorizontalCenter
Write-Color " ","                      "," " -Color Cyan, Cyan, Cyan -HorizontalCenter -Style None,Overline,None