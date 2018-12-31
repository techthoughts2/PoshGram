<#
.Synopsis
    Verifies that specified URL path contains a supported Telegram document type
.DESCRIPTION
    Evaluates the specified URL path to determine if the URL leads to a supported document type
.EXAMPLE
    Test-URLExtension -URL $URL

    Verifies if the URL path specified is a supported document extension type
.EXAMPLE
    Test-URLExtension -URL $URL -Verbose

    Verifies if the URL specified in $URL is a supported document extension type with verbose output
.PARAMETER URL
    The URL string to the specified online document
.OUTPUTS
    System.Boolean
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    https://core.telegram.org/bots/api#senddocument
    GIF, PDF, ZIP
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
#>
function Test-URLExtension {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = 'URL string of document')]
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
    if ($extension -eq "gif" -or $extension -eq "pdf" -or $extension -eq "zip") {
        Write-Verbose -Message "Extension verified."
    }#if_supportedExtensions
    else {
        Write-Warning -Message "The specified URL does not contain supported document extension."
        $results = $false
    }#else_supportedExtensions
    return $results
}#function_Test-URLExtension