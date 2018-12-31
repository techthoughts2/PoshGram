<#
.Synopsis
    Verifies that specified URL path contains a supported Telegram video type
.DESCRIPTION
    Evaluates the specified URL path to determine if the URL leads to a supported video type
.EXAMPLE
    Test-VideoURLExtension -URL $URL

    Verifies if the URL path specified is a supported video extension type
.EXAMPLE
    Test-VideoURLExtension -URL $URL -Verbose

    Verifies if the URL specified in $URL is a supported video extension type with verbose output
.PARAMETER URL
    The URL string to the specified online document
.OUTPUTS
    System.Boolean
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    MP4
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
#>
function Test-VideoURLExtension {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = 'URL string of video')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$URL
    )
    [bool]$results = $true #assume the best.
    Write-Verbose -Message "Processing $URL ..."
    $divide = $URL.Split(".")
    $rawExtension = $divide[$divide.Length - 1]
    $extension = $rawExtension.ToLower()
    Write-Verbose "Verifying discovered extension: $extension"
    if ($extension -eq "mp4") {
        Write-Verbose -Message "Extension verified."
    }#if_supportedExtensions
    else {
        Write-Warning -Message "The specified URL does not contain supported video extension."
        $results = $false
    }#else_supportedExtensions
    return $results
}#function_Test-VideoURLExtension