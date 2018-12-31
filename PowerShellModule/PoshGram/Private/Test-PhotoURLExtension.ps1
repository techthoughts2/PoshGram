<#
.Synopsis
    Verifies that specified URL path contains a supported Telegram photo type
.DESCRIPTION
    Evaluates the specified URL path to determine if the URL leads to a supported photo type
.EXAMPLE
    Test-PhotoURLExtension -URL $URL

    Verifies if the URL path specified is a supported photo extension type
.EXAMPLE
    Test-PhotoURLExtension -URL $URL -Verbose

    Verifies if the URL specified in $URL is a supported photo extension type with verbose output
.PARAMETER URL
    The URL string to the specified online document
.OUTPUTS
    System.Boolean
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    JPG, JPEG, PNG, GIF, BMP, WEBP, SVG, TIFF

.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
#>
function Test-PhotoURLExtension {
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
    if ($extension -eq "jpg" -or $extension -eq "jpeg" -or $extension -eq "png" -or $extension -eq "gif" -or $extension -eq "bmp" -or $extension -eq "webp" -or $extension -eq "svg" -or $extension -eq "tiff") {
        Write-Verbose -Message "Extension verified."
    }#if_supportedExtensions
    else {
        Write-Warning -Message "The specified URL does not contain supported photo extension."
        $results = $false
    }#else_supportedExtensions
    return $results
}#function_Test-PhotoURLExtension