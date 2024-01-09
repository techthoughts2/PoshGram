<#
.SYNOPSIS
    Resolve a URI to the URIs it redirects to
.DESCRIPTION
    Resolves a URI provided to the URI it redirects to. If no redirect is in place, null is returned. This is useful for resolving shortlinks to try url file paths.
.EXAMPLE
    Resolve-ShortLink -Uri http://gph.is/2y3AWRU

    Resolve shortlink to full URI
.PARAMETER Uri
    Uri you wish to resolve
.OUTPUTS
    System.String
    -or-
    Null
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/
.COMPONENT
    PoshGram
#>
function Resolve-ShortLink {
    [CmdletBinding()]
    param (
        ## The URI to resolve
        [Parameter(Mandatory = $true,
            HelpMessage = 'Uri you wish to resolve')]
        [string]$Uri
    )
    $result = $null
    $eval = $null
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    try {
        $eval = Invoke-WebRequest -Uri $uri -MaximumRedirection 0 -ErrorAction Stop
    } #try_Invoke-WebRequest
    catch {
        #if($_.ErrorDetails.Message -like "*maximum redirection*"){
        if ($_.Exception.Message -like "*Moved*") {
            $eval = $_
            Write-Verbose -Message 'Moved detected.'
            #$result = $eval.Headers.Location
            $result = $eval.Exception.Response.Headers.Location.AbsoluteUri
        } #if_Error_Moved
        else {
            Write-Warning -Message 'An Error was encountered resolving a potential shortlink:'
            Write-Error $_
        } #else_Error_Moved
    } #catch_Invoke-WebRequest
    return $result
} #Resolve-ShortLink
