<#
.Synopsis
    Verifies that specified file is a supported Telegram photo type
.DESCRIPTION
    Evaluates the specified file path to determine if the file is a supported photo type
.EXAMPLE
    Test-PhotoExtension -ImagePath C:\photos\aphoto.jpg

    Verifies if the path specified is a supported photo extension type
.EXAMPLE
    Test-PhotoExtension -ImagePath $ImagePath -Verbose

    Verifies if the path specified in $ImagePath is a supported photo extension type with verbose output
.PARAMETER ImagePath
    File path to the photo location
.OUTPUTS
    System.Boolean
.NOTES
    Author: Jake Morrison - @jakemorrison - http://techthoughts.info/
    JPG, JPEG, PNG, GIF, BMP, WEBP, SVG, TIFF
.COMPONENT
    PoshGram - https://github.com/techthoughts2/PoshGram
#>
function Test-PhotoExtension {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = 'File path to photo')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$ImagePath
    )
    [bool]$results = $true #assume the best.
    Write-Verbose -Message "Processing $ImagePath ..."
    $divide = $ImagePath.Split(".")
    $rawExtension = $divide[$divide.Length - 1]
    $extension = $rawExtension.ToLower()
    Write-Verbose "Verifying discovered extension: $extension"
    if ($extension -eq "jpg" -or $extension -eq "jpeg" -or $extension -eq "png" -or $extension -eq "gif" -or $extension -eq "bmp" -or $extension -eq "webp" -or $extension -eq "svg" -or $extension -eq "tiff") {
        Write-Verbose -Message "Extension verified."
    }#if_supportedExtensions
    else {
        Write-Warning -Message "The specified file is not a supported photo extension."
        $results = $false
    }#else_supportedExtensions
    return $results
}#function_Test-PhotoExtension