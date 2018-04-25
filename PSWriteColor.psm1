Write-Verbose "Importing Functions"

Export-ModuleMember -function (Get-ChildItem -Path "$PSScriptRoot\Write-Color.ps1").basename