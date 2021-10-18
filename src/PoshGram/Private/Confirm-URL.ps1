<#
.Synopsis
    Evaluates if the provided URL is reachable
.DESCRIPTION
    Evaluates if the provided URL is reachable and returns a boolean based on results
.EXAMPLE
    Confirm-URL -Uri http://gph.is/2y3AWRU

    Determines if the provided URL is accessible and returns a boolean based on results
.PARAMETER Uri
    Uri you wish to resolve
.OUTPUTS
    System.Boolean
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
#>
function Confirm-URL {
    [CmdletBinding()]
    param (
        ## The URI to resolve
        [Parameter(Mandatory = $true,
            HelpMessage = 'Uri you wish to resolve')]
        [string]$Uri
    )
    $result = $true #assume the best
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Write-Verbose -Message "Attempting to confirm $Uri"
    try {
        Invoke-WebRequest -Uri $uri -UseBasicParsing -DisableKeepAlive -ErrorAction Stop | Out-Null
        Write-Verbose -Message 'Confirmed.'
    } #try_Invoke-WebRequest
    catch {
        Write-Verbose -Message 'Catch on Invoke-WebRequest. This is not neccessarily a bad thing. Checking status code.'
        if ([int]$_.Exception.Response.StatusCode -eq 0) {
            Write-Warning -Message "$Uri"
            Write-Warning -Message 'The URL provided does not appear to be valid'
            $result = $false
        }
        #we will proceed with any other exit code
    } #catch_Invoke-WebRequest
    return $result
} #Confirm-URL
