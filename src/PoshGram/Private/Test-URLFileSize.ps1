<#
.SYNOPSIS
    Verifies that specified URL file size is supported by Telegram
.DESCRIPTION
    Evaluates the specified URL path to determine if the file is at or below the supported Telegram file size
.EXAMPLE
    Test-URLFileSize -URL 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/techthoughts.png'

    Verifies if the file in the specified URL is at or below the Telegram maximum size
.EXAMPLE
    Test-URLFileSize -URL $URL -Verbose

    Verifies if the file in the specified URL is at or below the Telegram maximum size with verbose output
.PARAMETER URL
    URL address to file
.OUTPUTS
    System.Boolean
.NOTES
    Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/
    Telegram currently supports a 50MB file size for bots
.COMPONENT
    PoshGram
#>
function Test-URLFileSize {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            HelpMessage = 'URL address to file')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$URL
    )
    $results = $true #assume the best
    $supportedSize = 50
    try {
        $urlFileInfo = Invoke-WebRequest $URL -ErrorAction Stop
        if (($urlFileInfo.RawContentLength / 1MB) -gt $supportedSize) {
            Write-Warning -Message "The file is over $supportedSize (MB)"
            $results = $false
        } #if_size
    } #try_Invoke-WebRequest
    catch {
        Write-Warning -Message 'An error was encountered evaluating the file size'
        $results = $false
    } #catch_Invoke-WebRequest
    return $results
} #function_Test-URLFileSize
