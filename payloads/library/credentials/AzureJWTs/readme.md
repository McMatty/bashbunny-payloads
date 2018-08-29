# BruteBunny

* Author: McMatty
* Version: Version 0.5
* Target: Windows

## Description

Having worked in a team that was starting its journay in the world of cloud with Azure I began wondering how
secure the PowerShell scripts being run by our DevOps teams were. Turns out quite secure - just the workstations
running them weren't.

This payload will look for all PowerShell hosted processes and inspect them to see if they contain any Azure JWTs
that are valid. Any tokens found will be dumped into the loot folder. Depending on the number of the PowerShell host 
processes found this can take sometime to inspect.

If the target is using an older version of AzureRM full process inspection is not needed as access to the token cache
appears to be shared with all PowerShell processes - not ideal.

## Configuration

Reguires the bunny_helpers.sh

## STATUS

| LED                | Status                                          |
| ------------------ | ----------------------------------------------- |
| Red                | Creating loot directory - removing previous loot|
| Blue  			 | Execute Extract-AzureJWTFromPowerShell.ps1      |
| Green    			 | JWT extracted and file saved to loot folder     |
| Red                | No loot - no tokens exist or it done goofed     |

## Discussion
Not yet
