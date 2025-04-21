<p align="center">
  <a href="https://www.powershellgallery.com/packages/PSWriteColor"><img src="https://img.shields.io/powershellgallery/v/PSWriteColor.svg"></a>
  <a href="https://www.powershellgallery.com/packages/PSWriteColor"><img src="https://img.shields.io/powershellgallery/vpre/PSWriteColor.svg?label=powershell%20gallery%20preview&colorB=yellow"></a>
  <a href="https://github.com/EvotecIT/PSWriteColor"><img src="https://img.shields.io/github/license/EvotecIT/PSWriteColor.svg"></a>
</p>

<p align="center">
  <a href="https://www.powershellgallery.com/packages/PSWriteColor"><img src="https://img.shields.io/powershellgallery/p/PSWriteColor.svg"></a>
  <a href="https://github.com/EvotecIT/PSWriteColor"><img src="https://img.shields.io/github/languages/top/evotecit/PSWriteColor.svg"></a>
  <a href="https://github.com/EvotecIT/PSWriteColor"><img src="https://img.shields.io/github/languages/code-size/evotecit/PSWriteColor.svg"></a>
  <a href="https://www.powershellgallery.com/packages/PSWriteColor"><img src="https://img.shields.io/powershellgallery/dt/PSWriteColor.svg"></a>
</p>

<p align="center">
  <a href="https://twitter.com/PrzemyslawKlys"><img src="https://img.shields.io/twitter/follow/PrzemyslawKlys.svg?label=Twitter%20%40PrzemyslawKlys&style=social"></a>
  <a href="https://evotec.xyz/hub"><img src="https://img.shields.io/badge/Blog-evotec.xyz-2A6496.svg"></a>
  <a href="https://www.linkedin.com/in/pklys"><img src="https://img.shields.io/badge/LinkedIn-pklys-0077B5.svg?logo=LinkedIn"></a>
</p>

# PSWriteColor - PowerShell module

Write-Color is a wrapper around Write-Host allowing you to create nice looking scripts, with colorized output.
More information for this project at my [Evotec website](https://evotec.xyz/hub/scripts/pswritecolor/).

## Support This Project

If you find this project helpful, please consider supporting its development.
Your sponsorship will help the maintainers dedicate more time to maintenance and new feature development for everyone.

It takes a lot of time and effort to create and maintain this project.
By becoming a sponsor, you can help ensure that it stays free and accessible to everyone who needs it.

To become a sponsor, you can choose from the following options:

 - [Become a sponsor via GitHub Sponsors :heart:](https://github.com/sponsors/PrzemyslawKlys)
 - [Become a sponsor via PayPal :heart:](https://paypal.me/PrzemyslawKlys)

Your sponsorship is completely optional and not required for using this project.
We want this project to remain open-source and available for anyone to use for free,
regardless of whether they choose to sponsor it or not.

If you work for a company that uses our .NET libraries or PowerShell Modules,
please consider asking your manager or marketing team if your company would be interested in supporting this project.
Your company's support can help us continue to maintain and improve this project for the benefit of everyone.

Thank you for considering supporting this project!

## ChangeLog

- 1.0.3 - 2025.04.21
  - 📃 Improves `HorizontalCenter` by AU-Mark
- 1.0.2 - 2025.04.21
  - 📃 Added `HorizontalCenter` by AU-Mark
- 1.0.1 - 2023.04.30
  - 🐛 Fixes UTF8 issue when publishing to PowerShell Gallery
- 1.0.0 - 2023.04.23
  - 📃 Converted tabs to spaces in code (no difference in output)
  - 📃 Updated documentation
  - 💡 Added `NoConsoleOutput` to allow only writting to file, and skipping console output
  - 🐛 Removed throwing exceptions when couldn't write to file (`Write-Warning` will be triggered instead)
- 0.87.3 - 2021.04.12
  - 💡 Disabled `WhatIf` functionality for Out-File which would prevent logging to file
  - 💡 Added `LogRetry` (2) to provide option to retry logging to file up to X number of times in case issue with saving to file occurs (race condition)
- 0.87.2 - 2020.07.20
  - 📦 Added a space for LogTime and ShowTime
  - 📦 Signed module
- 0.87.1 - 2020.06.19
  - 🐛 Resolves issue with nuget download (changed version from 0.87 to 0.87.1). As per [link](https://devblogs.microsoft.com/devops/versioning-nuget-packages-cd-1/) it requires version to be longer.
- 0.87.0 - 2020.01.12
  - 🐛 Throw errors when can't save to file with LogFile. Before it would use Write-Output which could deliver unpredictable results

# Quick install

```powershell
Install-Module -Name "PSWriteColor" -Force
```

# Examples

![Image](https://evotec.xyz/wp-content/uploads/2018/05/img_5af07118e9f87.png)

```powershell
# Example 1
Write-Color "[i] ", "Parameter in configuration of ", "EmailParameters.EmailFrom", " exists." -Color White, White, Green, White -ShowTime
Write-Color "[i] ", "Parameter in configuration of ", "EmailParameters.EmailTo", " exists." -Color White, White, Green, White -ShowTime
```

```powershell
# Example 2
Write-Color "[i] ", "I will send email soon...", "Get ready.." -Color White
Write-Color "[i] ", "Sending email...." -Color White, White -NoNewLine
<#
    Do Something....
#>
if ($true) {
    Write-Color -Text "OK" -Color Green
}
```

```powershell
# Example 3
Write-Color -Text "Red ", "Green ", "Yellow " -Color Red, Green, Yellow
Write-Color -Text "This is text in Green ",
"followed by red ",
"and then we have Magenta... ",
"isn't it fun? ",
"Here goes DarkCyan" -Color Green, Red, Magenta, White, DarkCyan
Write-Color -Text "This is text in Green ",
"followed by red ",
"and then we have Magenta... ",
"isn't it fun? ",
"Here goes DarkCyan" -Color Green, Red, Magenta, White, DarkCyan -StartTab 3 -LinesBefore 1 -LinesAfter 1
Write-Color "1. ", "Option 1" -Color Yellow, Green
Write-Color "2. ", "Option 2" -Color Yellow, Green
Write-Color "3. ", "Option 3" -Color Yellow, Green
Write-Color "4. ", "Option 4" -Color Yellow, Green
Write-Color "9. ", "Press 9 to exit" -Color Yellow, Gray -LinesBefore 1
Write-Color -LinesBefore 2 -Text "This little ", "message is ", "written to log ", "file as well." `
        -Color Yellow, White, Green, Red, Red -LogFile "C:\testing.txt" -TimeFormat "yyyy-MM-dd HH:mm:ss"
Write-Color -Text "This can get ", "handy if ", "want to display things, and log actions to file ", "at the same time." `
        -Color Yellow, White, Green, Red, Red -LogFile "C:\testing.txt"
```

```powershell
# Example 4 with backgrund colors and usage of aliases
Write-Color -T "My text", " is ", "all colorful" -C Yellow, Red, Green -B Green, Green, Yellow
Write-Color -T "My text", " is ", "all colorful" -C Yellow, Red, Green -B Red, Green, Green
# Example 5 with aliases
wc -t "my text" -C Red
```
